package com.jadic.biz;

import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.jboss.netty.buffer.ChannelBuffer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jadic.biz.bean.DBSaveBean;
import com.jadic.biz.bean.TerminalBean;
import com.jadic.cmd.AbstractCmd;
import com.jadic.cmd.req.AbstractCmdReq;
import com.jadic.cmd.req.CmdAddCashBoxAmountReq;
import com.jadic.cmd.req.CmdChargeDetailReq;
import com.jadic.cmd.req.CmdCheckCityCardTypeReq;
import com.jadic.cmd.req.CmdClearCashBox;
import com.jadic.cmd.req.CmdDefaultReq;
import com.jadic.cmd.req.CmdGetMac2Req;
import com.jadic.cmd.req.CmdGetServerTimeReq;
import com.jadic.cmd.req.CmdHeartbeatReq;
import com.jadic.cmd.req.CmdLoginReq;
import com.jadic.cmd.req.CmdModifyZHBPassReq;
import com.jadic.cmd.req.CmdModuleStatusReq;
import com.jadic.cmd.req.CmdOperLogReq;
import com.jadic.cmd.req.CmdPrepaidCardCheckReq;
import com.jadic.cmd.req.CmdQueryZHBBalanceReq;
import com.jadic.cmd.req.CmdRefundReq;
import com.jadic.cmd.req.CmdRefundWithReasonReq;
import com.jadic.cmd.req.CmdTYRetReq;
import com.jadic.cmd.rsp.CmdAddCashBoxAmountRsp;
import com.jadic.cmd.rsp.CmdChargeDetailRsp;
import com.jadic.cmd.rsp.CmdCheckCityCardTypeRsp;
import com.jadic.cmd.rsp.CmdGetMac2Rsp;
import com.jadic.cmd.rsp.CmdGetServerTimeRsp;
import com.jadic.cmd.rsp.CmdLoginRsp;
import com.jadic.cmd.rsp.CmdModifyZHBPassRsp;
import com.jadic.cmd.rsp.CmdPrepaidCardCheckRsp;
import com.jadic.cmd.rsp.CmdQueryZHBBalanceRsp;
import com.jadic.cmd.rsp.CmdRefundRsp;
import com.jadic.cmd.rsp.CmdTYRetRsp;
import com.jadic.db.DBOper;
import com.jadic.db.SQL;
import com.jadic.tcp.server.TcpChannel;
import com.jadic.utils.Const;
import com.jadic.utils.KKTool;
import com.jadic.ws.WSUtil;

/**
 * @author Jadic
 * @created 2014-4-14
 */
public class ThreadDisposeTcpChannelData implements Runnable {

    private final static Logger log = LoggerFactory.getLogger(ThreadDisposeTcpChannelData.class);
    private TcpChannel tcpChannel;
    private ICmdBizDisposer cmdBizDisposer;

    final static int MAX_DISPOSE_COUNT = 20;// 线程处理每个通道一次最多连续处理次数
    
    private final static Map<Integer, List<Short>> terminalCmdSNos = new ConcurrentHashMap<Integer, List<Short>>(); 

    public ThreadDisposeTcpChannelData(TcpChannel tcpChannel, ICmdBizDisposer cmdBizDisposer) {
        this.tcpChannel = tcpChannel;
        this.cmdBizDisposer = cmdBizDisposer;
    }

    @Override
    public void run() {
        boolean isSucc = tcpChannel.checkAndSetDisposeFlag();
        if (isSucc) {
            ChannelBuffer buffer = null;
            int disposeCount = 0;
            while ((buffer = tcpChannel.getNextBuffer()) != null) {
                disposeBuffer(buffer);
                disposeCount++;

                // if tcp channel is closed, dispose all buffer data in the
                // queue
                if (!tcpChannel.isClosed()) {
                    if (disposeCount >= MAX_DISPOSE_COUNT) {
                        log.warn("{} dispose buffer over {} times, left size:{}", tcpChannel, MAX_DISPOSE_COUNT,
                                tcpChannel.getBufferQueueSize());
                        break;
                    }
                }
            }
            if (!tcpChannel.isClosed()) {
                tcpChannel.setDisposing(false);
            } else {
                tcpChannel = null;
            }
            /*
             * if (disposeCount > 1) { KKLog.info(tcpChannel +
             * " dispose buffer " + disposeCount + " times"); }
             */
        }
    }

    private void disposeBuffer(ChannelBuffer buffer) {
        if (buffer == null || buffer.readableBytes() < Const.CMD_MIN_SIZE) {
            return;
        }

        short cmdFlag = buffer.getShort(buffer.readerIndex() + 1);

        // can't deal other cmd, unless terminal is logined
//        if (!tcpChannel.isLogined() && cmdFlag != Const.TER_LOGIN) {
//            dealInvalidCmd(buffer, Const.TY_RET_NO_LOGIN);
//            return;
//        }

        switch (cmdFlag) {
        case Const.TER_TY_RET:
            dealCmdTYRet(buffer);
            break;
        case Const.TER_HEARTBEAT:
            dealCmdHeartbeat(buffer);
            break;
        case Const.TER_LOGIN:
            dealCmdLogin(buffer);
            break;
        case Const.TER_MODULE_STATUS:
            dealCmdModuleStatus(buffer);
            break;
        case Const.TER_GET_MAC2:
            dealCmdGetMac2(buffer);
            break;
        case Const.TER_CHARGE_DETAIL:
        	dealCmdChargeDetail(buffer);
        	break;
        case Const.TER_REFUND:
            dealCmdRefund(buffer);
            break;
        case Const.TER_PREPAID_CARD_CHECK:
            dealCmdPrepaidCardCheck(buffer);
            break;
        case Const.TER_QUERY_ZHB_BALANCE:
            dealCmdQueryZHBBalance(buffer);
            break;
        case Const.TER_MODIFY_ZHB_PASS:
            dealCmdModifyZHBPass(buffer);
            break;
        case Const.TER_CHECK_CITY_CARD_TYPE:
            dealCmdCheckCityCardType(buffer);
            break;
        case Const.TER_CLEAR_CASH_BOX:
        	dealCmdClearCashBox(buffer);
        	break;
        case Const.TER_ADD_CASH_BOX_AMOUNT: 
        	dealCmdAddCashBoxAmount(buffer);
        	break;
        case Const.TER_OPER_LOG:
            dealCmdOperLog(buffer);
            break;
        case Const.TER_GET_SERVER_TIME:
            dealCmdGetServerTime(buffer);
            break;
        case Const.TER_REFUND_WITH_REASON:
            dealCmdRefundWithReason(buffer);
            break;
        default:
            dealInvalidCmd(buffer, Const.TY_RET_NOT_SUPPORTED);
            log.warn("Unsupported command flag:{}", KKTool.byteArrayToHexStr(KKTool.short2BytesBigEndian(cmdFlag)));
            break;
        }
    }

    private void dealCmdTYRet(ChannelBuffer buffer) {
        CmdTYRetReq cmdReq = new CmdTYRetReq();
        if (cmdReq.disposeData(buffer)) {
            log.debug("recv ty ret[{}] ", tcpChannel);
        } else {
            log.warn("recv cmd ty ret, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdHeartbeat(ChannelBuffer buffer) {
        CmdHeartbeatReq cmdReq = new CmdHeartbeatReq();
        if (cmdReq.disposeData(buffer)) {
            sendCmdTYRetOK(cmdReq);
            log.debug("recv heartbeat[{}] ", tcpChannel);
        } else {
            log.warn("recv cmd heartbeat, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdLogin(ChannelBuffer buffer) {
        CmdLoginReq cmdReq = new CmdLoginReq();
        if (cmdReq.disposeData(buffer)) {
            // this means tcpchannel is logined
            this.tcpChannel.setTerminalVer(cmdReq.getVer());
            this.setTcpchannelTerminalId(cmdReq);
            CmdLoginRsp cmdRsp = new CmdLoginRsp();
            cmdRsp.setCmdCommonField(cmdReq);
            cmdRsp.setCmdSNoRsp(cmdReq.getCmdSNo());

            byte ret = 0;
            TerminalBean terminal = getTerminal(cmdReq);
            if (terminal != null) {
                if (terminal.getEnabled() == 1) {// 停用
                    ret = 3;
                } else if (terminal.getChannelId() == -1 || terminal.getChannelId() == tcpChannel.getId()) {
                    ret = 0;
                } else {// 被占用
                    //ret = 1;  暂时去掉
                }
            } else {//该终端号不存在
                ret = 2;
            }
            cmdRsp.setRet(ret);
            sendData(cmdRsp.getSendBuffer());
            if (ret == 0) {
                addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_TERMINAL_ONLINE, "版本:" + KKTool.short2HexStr(cmdReq.getVer()));
            }
            log.info("a client login, login ret[{}], [{}], ver:{}", ret, tcpChannel, KKTool.short2HexStr(cmdReq.getVer()));
        } else {
            log.warn("recv cmd login, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdModuleStatus(ChannelBuffer buffer) {
        CmdModuleStatusReq cmdReq = new CmdModuleStatusReq();
        if (cmdReq.disposeData(buffer)) {
            sendCmdTYRetOK(cmdReq);
            log.info("recv module status[{}]", tcpChannel);
            if (this.cmdBizDisposer != null) {
            	this.cmdBizDisposer.disposeCmdModuleStatus(cmdReq);
            }
        } else {
            log.warn("recv cmd module status, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdGetMac2(ChannelBuffer buffer) {
        CmdGetMac2Req cmdReq = new CmdGetMac2Req();
        if (cmdReq.disposeData(buffer)) {
            log.info("recv get mac2[{}]", tcpChannel);
            CmdGetMac2Rsp cmdRsp = new CmdGetMac2Rsp();
            cmdRsp.setCmdCommonField(cmdReq);
            WSUtil.getWsUtil().getMac2(cmdReq, cmdRsp);//"00000000"
            sendData(cmdRsp.getSendBuffer());
        } else {
            log.warn("recv cmd get mac2, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdChargeDetail(ChannelBuffer buffer) {
    	CmdChargeDetailReq cmdReq = new CmdChargeDetailReq();
    	if (cmdReq.disposeData(buffer)) {
    		byte ret = 1;
    		long recordId = 0;
    		byte chargeStatus = cmdReq.getStatus();
    		byte chargeType = cmdReq.getChargeType();
    		int terminalId = cmdReq.getTerminalId();
    		if (chargeStatus == Const.CHARGE_DETAIL_STATUS_SUCC) {//仅保存成功交易的记录，失败的记录会有退款记录
        		recordId = DBOper.getDBOper().addNewChargeDetail(cmdReq);
        		if (recordId < 0) {
        		    ret = 0;
        		}
        		
        		if (tcpChannel.getTerminalVer() <= 0x0100 && chargeType == Const.CHARGE_TYPE_CASH) {
        			int amountAdded = cmdReq.getTransAmount() / 100;//转成元
        			addAsynSaveData(new DBSaveBean(SQL.ADD_CASH_AMOUNT).addParam(amountAdded).addParam(terminalId));
        			log.info("add cash box amount, terminalId:{}, amountAdded:{}", terminalId, amountAdded);
        		}
        		
        		String logMemo = "卡号:" + KKTool.byteArrayToHexStr(cmdReq.getCityCardNo()) + 
        		                ",类型:" + KKTool.getChargeTypeName(chargeType) + 
        		                ",金额:" + cmdReq.getTransAmount()/100;
        		addOperLog(terminalId, Const.LOG_TYPE_CHARGE, logMemo);
    		}
    		CmdChargeDetailRsp cmdRsp = new CmdChargeDetailRsp();
    		cmdRsp.setCmdCommonField(cmdReq);
    		cmdRsp.setRet(ret);
    		cmdRsp.setRecordId(recordId);
    		sendData(cmdRsp.getSendBuffer());
    		log.info("recv charge detail[{}]", tcpChannel);
    		if (this.cmdBizDisposer != null) {
    		    //只上传成功的现金和银行卡充值记录
    		    if (chargeStatus == Const.CHARGE_DETAIL_STATUS_SUCC && chargeType <= Const.CHARGE_TYPE_BANK_CARD) {
    		        this.cmdBizDisposer.disposeCmdChargeDetail(cmdReq);
    		    }
    		}
    	} else {
            log.warn("recv cmd charge detail, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdRefund(ChannelBuffer buffer) {
        CmdRefundReq cmdReq = new CmdRefundReq();
        if (cmdReq.disposeData(buffer)) {
            byte ret = 1;
            int recordId = DBOper.getDBOper().queryRepeatedRefund(cmdReq);
            if (recordId <= 0) {//无重复记录
                recordId = DBOper.getDBOper().addNewRefund(cmdReq);
                if (recordId < 0) {
                    ret = 0;
                    log.info("save refund data fail[{}]", tcpChannel);
                }
            } else {
                log.info("repeated refund record");
            }
            
            String logMemo = "卡号:" + KKTool.byteArrayToHexStr(cmdReq.getCityCardNo()) + 
                            ",类型:" + KKTool.getChargeTypeName(cmdReq.getChargeType()) + 
                            ",金额:" + cmdReq.getAmount()/100;
            addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_REFUND, logMemo);
            
            if (tcpChannel.getTerminalVer() <= 0x0100 && cmdReq.getChargeType() == Const.CHARGE_TYPE_CASH) {
            	int terminalId = cmdReq.getTerminalId();
    			int amountAdded = cmdReq.getAmount() / 100;//转成元
    			
    			DBSaveBean dataBean = new DBSaveBean(SQL.ADD_CASH_AMOUNT);
    			dataBean.addParam(amountAdded).addParam(terminalId);
    			addAsynSaveData(dataBean);
    			log.info("CmdRefund:add cash box amount, terminalId:{}, amountAdded:{}", terminalId, amountAdded);
    		}
            CmdRefundRsp cmdRsp = new CmdRefundRsp();
            cmdRsp.setCmdCommonField(cmdReq);
            cmdRsp.setRet(ret);
            cmdRsp.setRecordId(recordId);
            sendData(cmdRsp.getSendBuffer());
            log.info("recv cmd refund[{}]", tcpChannel);
        } else {
            log.warn("recv cmd refund, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdPrepaidCardCheck(ChannelBuffer buffer) {
        CmdPrepaidCardCheckReq cmdReq = new CmdPrepaidCardCheckReq();
        if (cmdReq.disposeData(buffer)) {
            CmdPrepaidCardCheckRsp cmdRsp = new CmdPrepaidCardCheckRsp();
            WSUtil.getWsUtil().checkPrepaidCard(cmdReq, cmdRsp);
            cmdRsp.setCmdCommonField(cmdReq);
            sendData(cmdRsp.getSendBuffer());
            log.info("recv cmd prepaid card check, ret:{}, amount:{}", cmdRsp.getCheckRet(), cmdRsp.getAmount());
        } else {
            log.warn("recv cmd prepaid card check, but fail to dispose[{}]", tcpChannel);
        }
    }

    private void dealCmdQueryZHBBalance(ChannelBuffer buffer) {
        CmdQueryZHBBalanceReq cmdReq = new CmdQueryZHBBalanceReq();
        if (cmdReq.disposeData(buffer)) {
            CmdQueryZHBBalanceRsp cmdRsp = new CmdQueryZHBBalanceRsp();
            WSUtil.getWsUtil().queryZHBBalance(cmdReq, cmdRsp);
            cmdRsp.setCmdCommonField(cmdReq);
            sendData(cmdRsp.getSendBuffer());
            addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_QUERY_ZHB_BALANCE, "卡号:" + KKTool.byteArrayToHexStr(cmdReq.getCityCardNo()));
            log.info("recv cmd query zhb balance, ret:{}, amount:{}", cmdRsp.getCheckRet(), cmdRsp.getAmount());
        } else {
            log.warn("recv cmd query zhb balance, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdModifyZHBPass(ChannelBuffer buffer) {
        CmdModifyZHBPassReq cmdReq = new CmdModifyZHBPassReq();
        if (cmdReq.disposeData(buffer)) {
            CmdModifyZHBPassRsp cmdRsp = new CmdModifyZHBPassRsp();
            cmdRsp.setCmdCommonField(cmdReq);
            WSUtil.getWsUtil().modifyZHBPassword(cmdReq, cmdRsp);
            sendData(cmdRsp.getSendBuffer());
            addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_MODIFY_ZHB_PASS, "卡号:" + KKTool.byteArrayToHexStr(cmdReq.getCardNo()));
            log.info("recv cmd modify zhb pass, ret:{}", cmdRsp.getRet());
        } else {
            log.warn("recv cmd modify zhb pass, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdCheckCityCardType(ChannelBuffer buffer) {
        CmdCheckCityCardTypeReq cmdReq = new CmdCheckCityCardTypeReq();
        if (cmdReq.disposeData(buffer)) {
            CmdCheckCityCardTypeRsp cmdRsp = new CmdCheckCityCardTypeRsp();
            cmdRsp.setCmdCommonField(cmdReq);
            cmdRsp.setCityCardNo(cmdReq.getCityCardNo());
            String cityCardNo = KKTool.byteArrayToHexStr(cmdReq.getCityCardNo());
            byte cityCardType = WSUtil.getWsUtil().checkCityCardType(cityCardNo);
            cmdRsp.setType(cityCardType);
            sendData(cmdRsp.getSendBuffer());
            log.info("recv cmd check city card type:{}", cmdRsp.getType());
        } else {
            log.warn("recv cmd check city card type, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdClearCashBox(ChannelBuffer buffer) {
    	CmdClearCashBox cmdReq = new CmdClearCashBox();
    	if (cmdReq.disposeData(buffer)) {
    	    sendCmdTYRetOK(cmdReq);
    		TerminalBean terminal = getTerminal(cmdReq);
    		if (terminal != null) {
    			terminal.setTotalCashAmount(0);
    		}
    		log.info("set cash box amount zero and add withdraw detail, terminalId:{}", cmdReq.getTerminalId());
    		
    		addAsynSaveData(new DBSaveBean(SQL.SET_CASH_AMOUNT_ZERO).addParam(cmdReq.getTerminalId()));
		    
		    DBSaveBean dataBean = new DBSaveBean(SQL.ADD_WITHDRAW_DETAIL);
		    dataBean.addParam(cmdReq.getTerminalId()).addParam(cmdReq.getCashAmount());
	        byte[] time = cmdReq.getOperTime();
	        int i = 0;
	        
	        Date operTime = KKTool.getBCDDateTime(time[i ++], time[i ++], time[i ++], time[i ++], time[i ++], time[i ++]);
	        dataBean.addParam(new Timestamp(operTime.getTime()));
	        
	        time = cmdReq.getLastOperTime();
	        i = 0;
	        operTime = KKTool.getBCDDateTime(time[i ++], time[i ++], time[i ++], time[i ++], time[i ++], time[i ++]);
	        dataBean.addParam(new Timestamp(operTime.getTime())).addParam(0);
	        addAsynSaveData(dataBean);
	        addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_WITHDRAW, "金额:" + cmdReq.getCashAmount());
    	} else {
    		log.warn("recv cmd clear cash box, but fail to dispose[{}]", tcpChannel);
    	}
    }
    
    private void dealCmdAddCashBoxAmount(ChannelBuffer buffer) {
    	CmdAddCashBoxAmountReq cmdReq = new CmdAddCashBoxAmountReq();
    	if (cmdReq.disposeData(buffer)) {
    	    if (cmdReq.getAmountAdded() <= 0) {
    	        log.warn("recv cmd add cash box amount,but amount added is not greater than 0,quit");
    	        return;
    	    }
    		TerminalBean terminal = getTerminal(cmdReq);
    		int totalCashAmount = 0;
    		if (terminal != null) {
    		    if (isCmdRepeated(cmdReq)) {
    		        totalCashAmount = terminal.getTotalCashAmount();
    		        log.info("repeated add cashbox amount, terminalId:{}, amountAdded:{}, totalAmount:{}", 
                            cmdReq.getTerminalId(), cmdReq.getAmountAdded(), totalCashAmount);
    		    } else {
        			terminal.addCashAmount(cmdReq.getAmountAdded());
        			totalCashAmount = terminal.getTotalCashAmount();
        			addAsynSaveData(new DBSaveBean(SQL.SET_CASH_AMOUNT).addParam(totalCashAmount).addParam(cmdReq.getTerminalId()));
        			log.info("set cashbox amount,terminalId:{}, amountAdded:{}, totalAmount:{}", 
        			        cmdReq.getTerminalId(), cmdReq.getAmountAdded(), totalCashAmount);
    		    }
    		}
    		CmdAddCashBoxAmountRsp cmdRsp = new CmdAddCashBoxAmountRsp();
    		cmdRsp.setCmdCommonField(cmdReq);
    		cmdRsp.setCashBoxTotalAmount(totalCashAmount);
    		sendCmd(cmdRsp);
    	} else {
            log.warn("recv cmd add cash box amount, but fail to dispose[{}]", tcpChannel);
    	}
    }
    
    /**
     * 检测命令是否重复<br>
     * 缓存列表中按终端设备区分，每个终端设备维护一个最近命令流水号的列表，检测到流水号已存在，则认为是重复流水号，列表中只缓存最近100个流水号
     * @param cmd
     * @return true:该终端流水号已重复发送
     */
    private boolean isCmdRepeated(AbstractCmd cmd) {
        if (cmd != null) {
            Integer terminalId = cmd.getTerminalId();
            Short cmdSNo = cmd.getCmdSNo();
            List<Short> cmdSNos = terminalCmdSNos.get(terminalId);
            if (cmdSNos != null) {
                if (cmdSNos.contains(cmdSNo)) {//重复
                    return true;
                } else {//未重复，则添加
                    cmdSNos.add(cmdSNo);
                    if (cmdSNos.size() > 100) {
                        cmdSNos.remove(0);
                    }
                }
            } else {//该设备未添加过命令流水号
                cmdSNos = Collections.synchronizedList(new LinkedList<Short>());
                cmdSNos.add(cmdSNo);
                terminalCmdSNos.put(terminalId, cmdSNos);
            }
        }
        return false;
    }
    
    private void dealCmdOperLog(ChannelBuffer buffer) {
        CmdOperLogReq cmdReq = new CmdOperLogReq();
        if (cmdReq.disposeData(buffer)) {
            sendCmdTYRetOK(cmdReq);
            addOperLog(cmdReq.getTerminalId(), cmdReq.getLogType(), "");
        } else {
            log.warn("recv cmd oper log, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    private void dealCmdGetServerTime(ChannelBuffer buffer) {
        CmdGetServerTimeReq cmdReq = new CmdGetServerTimeReq();
        if (cmdReq.disposeData(buffer)) {
            CmdGetServerTimeRsp cmdRsp = new CmdGetServerTimeRsp();
            cmdRsp.setCmdCommonField(cmdReq);
            sendCmd(cmdRsp);
            log.info("send server time[{}] to terminal[{}]", KKTool.byteArrayToHexStr(cmdRsp.getServerTime()), cmdRsp.getTerminalId());
        } else {
            log.warn("recv cmd get server time, but fail to dispose}", tcpChannel);
        }
    }
    
    private void dealCmdRefundWithReason(ChannelBuffer buffer) {
        CmdRefundWithReasonReq cmdReq = new CmdRefundWithReasonReq();
        if (cmdReq.disposeData(buffer)) {
            sendCmdTYRetOK(cmdReq);
            
            DBSaveBean dataBean = new DBSaveBean(SQL.ADD_REFUND_WITH_REASON);
            dataBean.addParam(KKTool.byteArrayToHexStr(cmdReq.getCityCardNo()));
            dataBean.addParam(cmdReq.getAmount());
            Date refundTime = KKTool.getBCDDateTime(cmdReq.getTime(), 0);
            dataBean.addParam(new Timestamp(refundTime.getTime()));
            dataBean.addParam(cmdReq.getTerminalId());
            dataBean.addParam(cmdReq.getChargeType());
            dataBean.addParam(new String(cmdReq.getReason(), Charset.forName("GBK")));
            addAsynSaveData(dataBean);
            
            String logMemo = "卡号:" + KKTool.byteArrayToHexStr(cmdReq.getCityCardNo()) + 
                            ",类型:" + KKTool.getChargeTypeName(cmdReq.getChargeType()) + 
                            ",金额:" + cmdReq.getAmount()/100;
            addOperLog(cmdReq.getTerminalId(), Const.LOG_TYPE_REFUND, logMemo);
            
            log.info("recv cmd refund[{}]", logMemo);
        } else {
            log.warn("recv cmd refund, but fail to dispose[{}]", tcpChannel);
        }
    }
    
    /**
     * 非法命令统一以通用应答处理
     * 
     * @param buffer
     * @param ret
     *            应答结果
     */
    private void dealInvalidCmd(ChannelBuffer buffer, byte ret) {
        CmdDefaultReq cmdReq = new CmdDefaultReq();
        if (cmdReq.disposeData(buffer)) {
            sendCmdTYRsp(cmdReq, ret);
        }
    }
    
    private void sendCmdTYRetOK(AbstractCmdReq cmdReq) {
    	sendCmdTYRsp(cmdReq, Const.TY_RET_OK);
    }

    /**
     * 回复通用应答
     * 
     * @param cmdReq
     * @param ret
     */
    private void sendCmdTYRsp(AbstractCmdReq cmdReq, byte ret) {
        CmdTYRetRsp cmdRsp = new CmdTYRetRsp();
        cmdRsp.setCmdCommonField(cmdReq);
        cmdRsp.setCmdFlagIdRsp(cmdReq.getCmdFlagId());
        cmdRsp.setCmdSNoRsp(cmdReq.getCmdSNo());
        cmdRsp.setRet(ret);
        sendData(cmdRsp.getSendBuffer());
    }

    private void sendData(ChannelBuffer buffer) {
        if (this.tcpChannel != null && !this.tcpChannel.isClosed()) {
            this.tcpChannel.sendData(KKTool.getEscapedBuffer(buffer));
        }
    }
    
    private void sendCmd(AbstractCmd cmd) {
    	if (cmd != null) {
    		sendData(cmd.getSendBuffer());
    	}
    }
    
    private void addOperLog(int terminalId, int logType, String logMemo) {
        DBSaveBean dataBean = new DBSaveBean(SQL.ADD_OPER_LOG);
        dataBean.addParam(terminalId).addParam(logType).addParam(logMemo);
        addAsynSaveData(dataBean);
    }
    
    private void addAsynSaveData(DBSaveBean dataBean) {
        if (this.cmdBizDisposer != null) {
            this.cmdBizDisposer.saveDBAsyn(dataBean);
        }
    }

    /**
     * 设置tcpchannel、terminal之间相互关联的值即tcpchannel.terminalId与terminal.channelId
     * 
     * @param cmdReq
     */
    private void setTcpchannelTerminalId(AbstractCmdReq cmdReq) {
        if (this.tcpChannel != null) {
            this.tcpChannel.setTerminalId(cmdReq.getTerminalId());
            TerminalBean terminal = getTerminal(cmdReq);
            if (terminal != null) {
                int oldChannelId = terminal.getChannelId();
                if (oldChannelId == -1) {
                    terminal.setChannelId(tcpChannel.getId());
                } else if (oldChannelId != tcpChannel.getId()) {
                    log.warn("channelid diff,new channelid[{}], old channelid[{}], terminalId[{}]", tcpChannel.getId(),
                            oldChannelId, terminal.getId());
                }
            } else {
                log.warn("can't find terminal bean by terminalId:{}", cmdReq.getTerminalId());
            }

        }
    }

    private TerminalBean getTerminal(AbstractCmdReq cmdReq) {
        return cmdReq == null ? null : BaseInfo.getBaseInfo().getTerminal(cmdReq.getTerminalId());
    }
    
}
