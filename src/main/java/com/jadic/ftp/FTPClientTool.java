/**
 * @author Jadic
 * @created 2012-4-24 
 */
package com.jadic.ftp;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.util.regex.Matcher;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPFileFilter;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FTPClientTool {
    
    private final static Logger log = LoggerFactory.getLogger(FTPClientTool.class);

	//private boolean isAnonymous;
	private String host;
	private int port;
	private String userName;
	private String userPass;
	private boolean isConnected;
	private boolean isLogined;
	private String encoding;
	
	private int downloadBufSize = 8 * 1024;//default, min 1 max 1024 * 1024;
	private int uploadBufSize = 10 * 1024;//default, min 1 max 1024 * 1024;

	public static final String ISO = "iso-8859-1";
	
	final static int FTP_TIMEOUT = 10000;

	private FTPClient ftpClient;

	public FTPClientTool(String host, int port, String userName, String userPass) {
		//this.isAnonymous = isAnonymous;
		this.host = host;
		this.port = port;
		this.userName = userName;
		this.userPass = userPass;
		this.isConnected = false;
		this.isLogined = false;
		this.encoding = "UTF-8";

		ftpClient = new FTPClient();
		ftpClient.setConnectTimeout(FTP_TIMEOUT);
		ftpClient.setDataTimeout(FTP_TIMEOUT);
		ftpClient.setDefaultTimeout(FTP_TIMEOUT);
		ftpClient.setControlEncoding(this.encoding);
		
//		this.ftpClient.addProtocolCommandListener(new PrintCommandListener(
//				new PrintWriter(System.out)));
	}

	/**
	 * connect to ftpserver
	 * @return
	 */
	public boolean connect() {
		try {
			ftpClient.connect(this.host, this.port);
			this.isConnected = FTPReply.isPositiveCompletion(ftpClient
					.getReplyCode());
			ftpClient.setSoTimeout(FTP_TIMEOUT);
		} catch (SocketException e) {
			this.isConnected = false;
			log.error("connect err", e);
		} catch (IOException e) {
		    log.error("connect err", e);
			this.isConnected = false;
		}
		return this.isConnected;
	}

	/**
	 * disconnect from ftpserver
	 */
	public void disConnect() {
		try {
			if (this.ftpClient.isConnected())
				this.ftpClient.disconnect();
		} catch (IOException e) {
		    log.error("disconnect err", e);
		}
		this.isConnected = false;
	}

	/**
	 * login to ftpserver
	 * @return
	 */
	public boolean login() {
		if (!this.isConnected)
			return false;

		try {
			if (this.userName.equals("") && this.userPass.equals(""))
				return false;
			isLogined = ftpClient.login(this.userName, this.userPass);
			return isLogined;
		} catch (IOException e) {
		    log.error("login err", e);
		}
		return false;
	}
	
	/**
	 * logout from ftpserver
	 * @return
	 */
	public boolean logout() {
		if (!this.isConnected || !this.ftpClient.isConnected())
			return false;
		try {
			this.isLogined = !this.ftpClient.logout();
			return this.isLogined;
		} catch (IOException e) {
		    log.error("logout err", e);
		}
		return false;
	}

	/**
	 * download file from ftpserver
	 * <p>
	 * 1.check remote file if exists
	 * <p>
	 * 2.if Support download from Breakpoint, check the file if downloaded or
	 * downloaded partially, if downloaded partially, download from the
	 * breakpoint
	 * <p>
	 * 3.if not support download from breakpoint, download the file
	 * <p>
	 * 
	 * @param remoteFile
	 *            absolute file path at ftpserver
	 * @param localFile
	 *            absolute file path at local disk
	 * @param isSupportBreakpoint
	 *            true to support download file from breakpoint, false to
	 *            override the file if existed
	 * @return ftpdownloadstatus 
	 */
	public FtpDownloadStatus download(String remoteFileName,
			String localFileName, boolean isSupportBreakpoint) {
		FtpDownloadStatus downloadStat = FtpDownloadStatus.DOWNLOAD_UNKNOWN;
		try {
			FTPFile remoteFtpFile = getRemoteFile(remoteFileName);
			if (remoteFtpFile != null) {
				long remoteFileSize = remoteFtpFile.getSize();
				File localFile = new File(localFileName);
				if (localFile.exists() && isSupportBreakpoint) {
					long localFileSize = localFile.length();
					if (localFileSize >= remoteFileSize) {
						downloadStat = FtpDownloadStatus.DOWNLOAD_FILE_DOWNLOADED;
					} else {
						downloadStat = downloadFile(remoteFtpFile, remoteFileName,
								localFile, localFileSize);
					}
				} else {
					downloadStat = downloadFile(remoteFtpFile, remoteFileName,
							localFile, 0);
				}
			} else {
				downloadStat = FtpDownloadStatus.DOWNLOAD_REMOTE_FILE_NOT_EXIST;
			}
		} catch (Exception e) {
		    log.error("logout err", e);
		}

		return downloadStat;
	}
	
	/**
	 * write remote file content to local file
	 * @param remoteFtpFile
	 * @param remoteFileName
	 * @param localFile
	 * @param offset
	 * @return
	 */
	private FtpDownloadStatus downloadFile(FTPFile remoteFtpFile,
			String remoteFileName, File localFile, long offset) {
		FtpDownloadStatus downloadStat = FtpDownloadStatus.DOWNLOAD_UNKNOWN;

		if (remoteFileName != null && localFile != null) {
			OutputStream outputStream = null;
			InputStream inputStream = null;
			try {
				if (offset == 0) {
					outputStream = new FileOutputStream(localFile, false);
				} else {
					outputStream = new FileOutputStream(localFile, true);
				}
				this.ftpClient.enterLocalPassiveMode();
				this.ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
				this.ftpClient.setRestartOffset(offset);

				inputStream = this.ftpClient.retrieveFileStream(remoteFileName);
				if (inputStream != null) {
					byte[] buf = new byte[this.downloadBufSize];// 8k per read
					int c = 0;
					while ((c = inputStream.read(buf)) != -1) {
						outputStream.write(buf, 0, c);
					}
					outputStream.flush();
					downloadStat = ftpClient.completePendingCommand() ? (offset == 0 ? FtpDownloadStatus.DOWNLOAD_SUCC_NEW : FtpDownloadStatus.DOWNLOAD_SUCC_BREAK)
																	  : (offset == 0 ? FtpDownloadStatus.DOWNLOAD_FAIL_NEW : FtpDownloadStatus.DOWNLOAD_FAIL_BREAK);
				} else {
					downloadStat = FtpDownloadStatus.DOWNLOAD_FAIL_NO_AUTH;
				}
			} catch (FileNotFoundException e) {
				downloadStat = (offset == 0 ? FtpDownloadStatus.DOWNLOAD_FAIL_NEW : FtpDownloadStatus.DOWNLOAD_FAIL_BREAK);
				log.error("Ftp download File FileNotFoundException", e);
			} catch (SocketTimeoutException e) {
				downloadStat = (offset == 0 ? FtpDownloadStatus.DOWNLOAD_FAIL_TIMEOUT_NEW : FtpDownloadStatus.DOWNLOAD_FAIL_TIMEOUT_BREAK);
				log.error("Ftp download File SocketTimeoutException", e);
			} catch (IOException e) {
				downloadStat = (offset == 0 ? FtpDownloadStatus.DOWNLOAD_FAIL_IOEXCEPTION_NEW : FtpDownloadStatus.DOWNLOAD_FAIL_IOEXCEPTION_BREAK);
				log.error("Ftp download File IOException", e);
			} catch (Exception e) {
				downloadStat = (offset == 0 ? FtpDownloadStatus.DOWNLOAD_FAIL_NEW : FtpDownloadStatus.DOWNLOAD_FAIL_BREAK);
				log.error("Ftp download File Exception", e);
			} finally {
				if (outputStream != null) {
					try {
						outputStream.close();
						outputStream = null;
					} catch (IOException e) {
						downloadStat = FtpDownloadStatus.DOWNLOAD_CLOSEREMOTESTREAM_ERROR;
					}
				}

				if (inputStream != null) {
					try {
						inputStream.close();
					} catch (IOException e) {
						downloadStat = FtpDownloadStatus.DOWNLOAD_CLOSELOCALSTREAM_ERROR;
					}
				}
			}
		}

		return downloadStat;
	}
	
	/**
	 * get FTPFile by file name
	 * 
	 * @param remoteFile
	 * @return FTPFile
	 */
	private FTPFile getRemoteFile(String remoteFile) {
		FTPFile ftpFile = null;
		try {
			this.ftpClient.enterLocalPassiveMode();
			FTPFile[] ftpFiles = this.ftpClient.listFiles(remoteFile);
			if (ftpFiles.length == 1)//
				ftpFile = ftpFiles[0];
		} catch (IOException e) {
			ftpFile = null;
		}
		return ftpFile;
	}
	
	/**
	 * list all files in the specified remote directory
	 * @param remotePath
	 * @return
	 */
	public FTPFile[] listFtpFiles(String remotePath) {
		FTPFile[] ftpFiles = null;
		if (this.isConnected()) {
			ftpClient.enterLocalPassiveMode();
			try {
				ftpFiles = ftpClient.listFiles(remotePath);
			} catch (IOException e) {
			}
		}
		return ftpFiles;
	}
	
	/**
	 * list all files in the specified remote directory with FtpFileFilter
	 * @param remotePath
	 * @param fileFilter
	 * @return
	 */
	public FTPFile[] listFtpFiles(String remotePath, FTPFileFilter fileFilter) {
		FTPFile[] ftpFiles = null;
		if (this.isConnected()) {
			ftpClient.enterLocalPassiveMode();
			try {
				ftpFiles = ftpClient.listFiles(remotePath, fileFilter);
			} catch (IOException e) {
			}
		}
		return ftpFiles;
	}

	/**
	 * upload local file to ftpserver <br>&nbsp;
	 * 1.check local file exist<br>&nbsp;
	 * 2.check remote dir exist, if not exist, create dir<br>&nbsp;
	 * 3.check remote file if need upload from breakpoint
	 * @param remoteFile
	 *            absolute file path at ftpserver. seperator:'/'
	 * @param localFile
	 *            absolute file path at local disk
	 * @param isSupportBreakpoint
	 *            true to support upload file from breakpoint
	 * @return FtpUploadStatus
	 */
	public FtpUploadStatus upload(String remoteFileName, String localFileName,
			boolean isSupportBreakpoint) {
		FtpUploadStatus uploadStat = FtpUploadStatus.UPLOAD_UNKNOWN;
		File localFile = new File(localFileName);
		if (localFile.exists()) {
			FTPFile remoteFtpFile = getRemoteFile(remoteFileName);
			if (remoteFtpFile == null) {// remote file not exist, create dir if need at ftpserver
				if(!createRemoteDir(remoteFileName)) {
					uploadStat = FtpUploadStatus.UPLOAD_REMOTE_DIR_CREATE_FAIL;
					return uploadStat;
				}
			}
			if (isSupportBreakpoint && remoteFtpFile != null) {
				long offset = 0;
				long localFileSize = localFile.length();
				long remoteFileSize = remoteFtpFile.getSize();
				
				if (remoteFileSize < localFileSize) {
					offset = remoteFileSize;
					uploadStat = uploadFile(remoteFtpFile, remoteFileName, localFile, offset);
				} else {// uploaded
					uploadStat = FtpUploadStatus.UPLOAD_FILE_UPLOADED;
				}
			} else {
				uploadStat = uploadFile(remoteFtpFile, remoteFileName, localFile, 0);
			}
		} else {
			uploadStat = FtpUploadStatus.UPLOAD_LOCAL_FILE_NOT_EXIST;
		}
		return uploadStat;
	}

	/**
	 * 
	 * @param remoteFileName
	 * @return
	 */
	private boolean createRemoteDir(String remoteFileName) {
		try {
			remoteFileName = remoteFileName.replaceAll(Matcher.quoteReplacement("\\"), "/");
			this.ftpClient.changeWorkingDirectory("/");
			int fsIndex = remoteFileName.lastIndexOf("/");
			if (fsIndex > 0) {
				String[] dirs = remoteFileName.split("/");
				StringBuilder parentDir = new StringBuilder("");
				for(int i = 0; i < dirs.length - 1; i ++) {
					if (dirs[i].equals(""))
						continue;
					this.ftpClient.makeDirectory(dirs[i]);
					parentDir.append("/" + dirs[i]);
					this.ftpClient.changeWorkingDirectory(parentDir.toString());
				}
			} else {
				return true;
			}
		} catch (IOException e) {
			return false;
		}
		return true;
	}
	
	/**
	 * write local file content to remote file at ftpserver
	 * @param remoteFtpFile
	 * @param remoteFileName
	 * @param localFile
	 * @param offset
	 * @return
	 */
	private FtpUploadStatus uploadFile(FTPFile remoteFtpFile,
			String remoteFileName, File localFile, long offset) {
		FtpUploadStatus uploadStatus = FtpUploadStatus.UPLOAD_UNKNOWN;
		RandomAccessFile raf = null;
		OutputStream outputStream = null;
		try {
			this.ftpClient.enterLocalPassiveMode();
			this.ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
			raf = new RandomAccessFile(localFile, "r");
			remoteFileName = remoteFileName.replaceAll(Matcher.quoteReplacement("\\"), "/");
			int i = remoteFileName.lastIndexOf("/");
			if (i > 0) {
				this.ftpClient.changeWorkingDirectory(remoteFileName.substring(0, i));//make sure
				remoteFileName = remoteFileName.substring(i + 1);
			}
			outputStream = this.ftpClient.appendFileStream(remoteFileName);
			if (offset > 0) {
				this.ftpClient.setRestartOffset(offset);
				raf.seek(offset);
			}
			byte[] buf = new byte[this.uploadBufSize];
			int c = 0;
			while ((c = raf.read(buf)) != -1) {
				outputStream.write(buf, 0, c);
			}
			outputStream.flush();
			outputStream.close();
			raf.close();
			uploadStatus = ftpClient.completePendingCommand() ? (offset == 0 ? FtpUploadStatus.UPLOAD_SUCC_NEW : FtpUploadStatus.UPLOAD_SUCC_BREAK)
																: (offset == 0 ? FtpUploadStatus.UPLOAD_FAIL_NEW : FtpUploadStatus.UPLOAD_FAIL_BREAK);
		} catch (FileNotFoundException e) {
			uploadStatus = (offset == 0 ? FtpUploadStatus.UPLOAD_FAIL_NEW : FtpUploadStatus.UPLOAD_FAIL_BREAK);
		} catch(SocketTimeoutException e) {
			uploadStatus = (offset == 0 ? FtpUploadStatus.UPLOAD_FAIL_TIMEOUT_NEW : FtpUploadStatus.UPLOAD_FAIL_TIMEOUT_BREAK);
		} catch (IOException e) {
			uploadStatus = (offset == 0 ? FtpUploadStatus.UPLOAD_FAIL_IOEXCEPTION_NEW : FtpUploadStatus.UPLOAD_FAIL_IOEXCEPTION_BREAK);
		} catch (Exception e) {
			uploadStatus = (offset == 0 ? FtpUploadStatus.UPLOAD_FAIL_NEW : FtpUploadStatus.UPLOAD_FAIL_BREAK);
		} finally {
			if (outputStream != null) {
				try {
					outputStream.close();
					outputStream = null;
				} catch (IOException e) {
					uploadStatus = FtpUploadStatus.UPLOAD_CLOSEREMOTESTREAM_ERROR;
				}
			}
			
			if (raf != null) {
				try {
					raf.close();
					raf = null;
				} catch (IOException e) {
					uploadStatus = FtpUploadStatus.UPLOAD_CLOSELOCALSTREAM_ERROR;
				}
			}
		}
		return uploadStatus;
	}
	
	public String getHost() {
		return host;
	}

	public int getPort() {
		return port;
	}

	public String getUserName() {
		return userName;
	}

	public String getUserPass() {
		return userPass;
	}

	public boolean isConnected() {
		return isConnected && ftpClient.isConnected() && this.isLogined;
	}

	public String getEncoding() {
		return encoding;
	}

	public void setEncoding(String encoding) {
		if (encoding != null && !encoding.equals(this.encoding)) {
			this.encoding = encoding;
			this.ftpClient.setControlEncoding(this.encoding);
		}
	}

	public int getDownloadBufSize() {
		return downloadBufSize;
	}

	public void setDownloadBufSize(int downloadBufSize) {
		this.downloadBufSize = downloadBufSize > 0 && downloadBufSize <= 1024 * 1024 ? downloadBufSize : this.downloadBufSize;;
	}

	public int getUploadBufSize() {
		return uploadBufSize;
	}

	public void setUploadBufSize(int uploadBufSize) {
		this.uploadBufSize = uploadBufSize > 0 && uploadBufSize <= 1024 * 1024 ? uploadBufSize : this.uploadBufSize;
	}
}