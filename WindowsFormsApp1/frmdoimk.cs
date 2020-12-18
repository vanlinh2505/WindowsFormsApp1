﻿using GlobalVariables;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApp1.DAO;
using WindowsFormsApp1.Model;

namespace WindowsFormsApp1
{
    public partial class frmdoimk : Form
    {
        public frmdoimk()
        {
            InitializeComponent();
            label4.Text = id;
        }
        private string id;
        public string getid
        {
            set { id=value; }
        }
        //void load()
        //{
        //    DAONhanVien nv = new DAONhanVien();
        //    NhanVien NVien = new NhanVien();
        //    NVien = nv.getNhanVienByID(Globals.NV);
        //}
        private void btn_cancer_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txt_mkcu_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_mkmoi_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_mkmoi2_TextChanged(object sender, EventArgs e)
        {

        }
        public static string HashPasswordUsingMD5(string password)
        {
            using (var md5 = MD5.Create())
            {
                byte[] passwordBytes = Encoding.ASCII.GetBytes(password);

                byte[] hash = md5.ComputeHash(passwordBytes);

                var stringBuilder = new StringBuilder();

                for (int i = 0; i < hash.Length; i++)
                    stringBuilder.Append(hash[i].ToString("X2"));

                return stringBuilder.ToString();
            }
        }
        private void btn_doimk_Click_1(object sender, EventArgs e)
        {
            try
            {
            if (txt_mkcu.Text == "" || txt_mkmoi.Text == "" || txt_mkmoi2.Text == "")
            {
                MessageBox.Show("không được để rỗng");
            }
            else
            {
                if (txt_mkmoi.Text != txt_mkmoi2.Text)
                {
                    MessageBox.Show("mật khẩu mới phải có độ dài bằng nhau");
                }
                else
                {
                    DAONhanVien nv = new DAONhanVien();
                    NhanVien NV = nv.getNhanVienByID(Globals.NV);
                    //MessageBox.Show(NV.Password);
                    //MessageBox.Show(HashPasswordUsingMD5(txt_mkcu.Text).ToLower());
                    if (HashPasswordUsingMD5(txt_mkcu.Text).ToLower() == NV.Password && txt_mkmoi.Text == txt_mkmoi2.Text)
                    {
                        //MessageBox.Show(NV.Password);
                        NV.Password = HashPasswordUsingMD5(txt_mkmoi.Text);
                        nv.suaNV(NV);
                        MessageBox.Show("Doi mat khau thanh cong");
                    }
                }
            }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btn_cancer_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txt_mkmoi2_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btn_doimk_Click_1(this, new EventArgs());
            }
        }
    }
}
