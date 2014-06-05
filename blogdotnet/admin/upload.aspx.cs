using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (filMyFile.PostedFile != null)
        {
            
            HttpPostedFile myFile = filMyFile.PostedFile;
 
           
            int nFileLen = myFile.ContentLength;
            byte[] myData = new byte[nFileLen];
            myFile.InputStream.Read(myData, 0, nFileLen);

            string strPath = Server.MapPath("./upload/" + Path.GetFileName(myFile.FileName));
            string pf = "./upload/" + Path.GetFileName(myFile.FileName);
            string nf = Path.GetFileName(myFile.FileName);
            
            FileStream newFile = new FileStream(strPath, FileMode.Create); 
            newFile.Write(myData, 0, myData.Length);
            newFile.Close();

           
            this.lbResult.Text = "File correctly uploaded";

           
            string buf = System.Text.Encoding.Default.GetString(myData);

            
            divlink.InnerHtml = "<a href=\"#\" onclick=\"Javascript:insertupl('"+pf+"', '"+nf+"')\";>Close and Add Attachment</a><br/>";
            
            
        }
    }
}
