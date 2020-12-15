﻿using GlobalVariables;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApp1.DAO;
using WindowsFormsApp1.Model;

namespace WindowsFormsApp1
{
    public partial class frmdsban : Form
    {
        public frmdsban()
        {
            InitializeComponent();
        }

        public void createButton()
        {
            List<Table> tableList = new List<Table>();
            DAOTable a = new DAOTable();
            tableList = a.LoadTable();
            foreach (Table item in tableList)
            {
                Button bt = new Button()
                {
                    Width = Convert.ToInt32(Table.tbwidth),
                    Height = Convert.ToInt32(Table.tbHeight)
                };
                switch (item.TableStatus1)
                {
                    case "Available":
                        bt.BackColor = Color.BlueViolet;
                        bt.Text = item.Tenban + Environment.NewLine + item.TableStatus1;
                        break;
                    default:
                        bt.BackColor = Color.Red;
                        bt.Text = item.Tenban + Environment.NewLine + item.TableStatus1 + Environment.NewLine ;
                        break;

                }
                bt.Tag = item.Maban;
                bt.Click += Bt_Click;

                flp.Controls.Add(bt);
            }
        }

        private void Bt_Click(object sender, EventArgs e)
        {
            Button bt = sender as Button;
            object a = bt.Tag;
            Globals.SetMaban ( Convert.ToInt32(a));
            frmdatdonhang frm = new frmdatdonhang();
            DAOHoaDon hd = new DAOHoaDon();
            // kt xem ban co dang su dung hay ko 
            DAOTable ban = new DAOTable();
            DAOChiTietHoaDon ct = new DAOChiTietHoaDon();
            if (ban.KTBanDangSD(Globals.Maban))
            {
                Globals.SetMahoadon(hd.getCurrentMahoadon(Globals.Maban));
                Globals.SetChiTietHoaDon(ct.getcurrentChitiethoadon(Globals.Mahoadon));
                
            }    


            
            frm.Show();
            frm.FormClosed += Frm_FormClosed;
        }

        private void Frm_FormClosed(object sender, FormClosedEventArgs e)
        {
            flp.Controls.Clear();
            createButton();
        }

        private void frmgiaodienchinh_Load(object sender, EventArgs e)
        {
            List<Table> tableList = new List<Table>();
            
            DAOTable a = new DAOTable();
            tableList = a.LoadTable();
         
            foreach (Table item in tableList)
            {
               
                Button bt = new Button()
                {
                    Width = Convert.ToInt32(Table.tbwidth),
                    Height = Convert.ToInt32(Table.tbHeight)
                };
                switch (item.TableStatus1)
                {
                    case "Available":
                        bt.BackColor = Color.BlueViolet;
                        bt.Text = item.Tenban + Environment.NewLine + item.TableStatus1;
                        break;
                    default:
                        bt.BackColor = Color.Red;
                        
                        bt.Text = item.Tenban + Environment.NewLine + item.TableStatus1 + Environment.NewLine ;
                        break;

                }
                bt.Tag = item.Maban;
                bt.Click += Bt_Click;
                flp.Controls.Add(bt);
            }

        }

        private void btRefresh_Click(object sender, EventArgs e)
        {
            flp.Controls.Clear();
            createButton();
        }

        private void btDelete_Click(object sender, EventArgs e)
        {
            DAOTable a = new DAOTable();
            int ID = a.deleteTable();
            foreach (Button item in flp.Controls)
            {
                if (Convert.ToInt32(item.Tag) == ID)
                {
                    flp.Controls.Remove(item);
                }
            }
            flp.Controls.Clear();
            createButton();
        }

        private void btAddTabel_Click(object sender, EventArgs e)
        {
            DAOTable a = new DAOTable();
            
            Table b = new Table();

            b=a.addTable();
            Button bt = new Button()
            {
                Width = Convert.ToInt32(Table.tbwidth),
                Height = Convert.ToInt32(Table.tbHeight)
            };
            bt.BackColor = Color.BlueViolet;
            bt.Text = b.Tenban + Environment.NewLine + b.TableStatus1;
            bt.Tag = b.Maban;
            bt.Click += Bt_Click;
            flp.Controls.Add(bt);
        }
    }
}
