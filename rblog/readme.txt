RBlog 1.0
By Mike DeWolfe (mike@dewolfe.bc.ca)

---------------------- README.TXT ----------------------

The zip file contains all of the components needed to install
and use the RBlog application.

1. Terms And Conditions
2. Included Files
3. Prerequisites
4. Use
5. Digital Alms

1. Terms And Conditions
-----------------------------------------------------------------
These programs are shareware, they may be used for an UNLIMITED period 
of evaluation free of charge, by private users only. They are not 
Freeware and are not allowed to be used in a commercial or government 
environment. If you like them you should register in order to gain all 
the benefits. The included files are are created, owned and licensed 
exclusively by Mike DeWolfe, Web: www.dewolfe.bc.ca . Reverse-engineering 
or modifying this software with the exception of HTML modifications is 
strictly prohibited.
 
LIMITED WARRANTY:

THESE PROGRAMS AND ACCOMPANYING WRITTEN MATERIALS ARE PROVIDED "AS IS" 
WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, 
BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS 
FOR A PARTICULAR PURPOSE. NEITHER THE AUTHOR NOR ANYONE ELSE WHO HAS 
BEEN INVOLVED IN THE CREATION, PRODUCTION OR DELIVERY OF THIS PRODUCT 
SHALL BE LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL OR INCIDENTAL 
DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE SUCH PRODUCT EVEN 
IF THE AUTHOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

BY USING THIS APPLICATION AND/OR ANY ONE OF THESE ACTIVE SERVER PAGES,
YOU EXPLICITLY AGREE TO THESE TERMS AND CONDITIONS.


2. Included Files
-----------------------------------------------------------------
readme.txt
---	The readme file that you reading.

install.asp     
---	This is a script that will test whether your directories are set up
properly and cofigure passwords, and other needed information. When run
successfully, it will A) make an ASP called data/locals.asp; B) it will alter 
rss/incinstall.asp. To re-use the setup script, you will have to re-upload 
rss/incinstall.asp again.

admin*.asp
---	The administration files used to manipulate the RBlog entries and users.

add.asp, edit.asp
---	Add.asp and Edit.asp allow logged in users to add new RSS entries, edit 
them or delete them. Entries are written into a static file in the /rss/ 
sub-directory. Each time a user's entries (one or more entries) are altered, 
the list of RSS entries will be rewritten, newest to oldest. There is the option
to expire entries of a certain age and exclude them from the list of RSS
entries to be included.

header.asp, footer.asp, soon.asp
---	Include files added to a number of pages. By changing these files, you
can change the look of the RBlog pages. 

allfeeds.asp     
---	All active users have their entries stored here. You have the option of 
seeing the RSS feed in its raw form; see the HTML version of the RSS feed; or
link to the home page for that user.

searchfeeds.asp
---	Look up entries via a search engine that reads the description and titles.
You can reference this feed as a URL to get all of the matching entries. By adding
"&xml=yes" to the QueryString, the feed can be served as a RSS/XML feed.

rblog.mdb
---	This Access '97 database holds all of the RSS entries and User profiles.

admin.mdb
---	This Access '97 database holds all of the Admin passwords.

alms.html
---	Digital Alms. I am not beyond the need for money. If you feel that 
this application is worthwhile, feel free to open up the alms.html,
click on the PayPal link and gift to me anything from $5 to $10 for the
use of this application. In return, you get product updates into 
perpetuity.


3. Prerequisites
-----------------------------------------------------------------
These are the prerequsities:
- Microsoft IIS 4.0 or better
- A writable directory (data) to store the database and the locale.asp file
- A writable directory (rss) to store the static RSS files.

4. Use
-----------------------------------------------------------------

4.1 Installation
------------------------------
- The first thing you need to do is UNZIP the rblog.zip file. Take all 
of those files and upload in BINARY to a writeable directory on your 
server.
- Then run the file called "install.asp" (e.g. if you uploaded these to
http://www.example.com/gallery, then you will need to run 
http://www.example.com/gallery/install.asp ). Provide the information it
required and hit "submit"

4.2 Admin Functions
------------------------------
These are some of the admin functions. Once you log in (by going to
/adminlogin,asp), the system will remember your identity for roughly 
20 minutes.

4.2.1 Add, Edit Delete Users
--------------------------------
You can add, edit and delete users to your RBlog system

4.2.2 Add, Edit Delete News
--------------------------------
You can add, edit and delete stories from your RBlog system. You can also
move stories from one user to another by re-assigning the User in ownership
of that story.

4.2.3 Add, Edit Delete Admins
----------------------------------
You can create other administrators, edit their info or remove them from the 
system.

5. Digital Alms
-----------------------------------------------------------------
If you feel that this application is worth enough to you, feel free
to donate a small sum. Go the page entitled "alms.html" and click on
the PayPal link.