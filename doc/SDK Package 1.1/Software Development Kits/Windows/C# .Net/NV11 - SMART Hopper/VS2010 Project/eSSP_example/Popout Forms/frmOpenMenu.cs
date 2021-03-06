﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

namespace eSSP_example
{
    public partial class frmOpenMenu : Form
    {
        string[] m_ComPorts;
        Form1 m_Parent;

        public frmOpenMenu(Form1 frm)
        {
            InitializeComponent();
            m_Parent = frm;
            if (SearchForComPorts() > 0)
            {
                cbComPort.Items.AddRange(m_ComPorts);
                cbComPort.Text = Properties.Settings.Default.ComPort;
            }
            else
            {
                MessageBox.Show("No com ports found!", "ERROR");
                Application.Exit();
            }
            tbSSPAddressVal1.Text = Properties.Settings.Default.SSP1.ToString();
            tbSSPAddressVal2.Text = Properties.Settings.Default.SSP2.ToString();
        }

        public int SearchForComPorts()
        {
            m_ComPorts = SerialPort.GetPortNames();
            return m_ComPorts.Length;
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (tbSSPAddressVal1.Text != "")
                {
                    Global.ComPort = cbComPort.SelectedItem.ToString();
                    Global.Validator1SSPAddress = Byte.Parse(tbSSPAddressVal1.Text);
                    Global.Validator2SSPAddress = Byte.Parse(tbSSPAddressVal2.Text);

                    Properties.Settings.Default.ComPort = Global.ComPort;
                    Properties.Settings.Default.SSP1 = Global.Validator1SSPAddress;
                    Properties.Settings.Default.SSP2 = Global.Validator2SSPAddress;
                    Properties.Settings.Default.Save ();

                    m_Parent.Show();
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "EXCEPTION");
            }
        }

        private void tbSSPAddress_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Return)
                btnSearch_Click(sender, e);
        }

        private void frmOpenMenu_Load(object sender, EventArgs e)
        {
            this.ControlBox = false;
        }
    }
}
