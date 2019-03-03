!!
ftp.open url,port,user,pass
ftp.put source,dest
ftp.get source,dest
ftp.delete file
ftp.dir n >list pointer<

GRABFILE data$, place$
TEXT.INPUT newdata$, old$
TEXT.OPEN w,fpointer,fn$
TEXT.WRITELN fpointer,data1$
TEXT.CLOSE f

file.dir place$,a$[]
array.length var,a$[]
!!

fn.def showdir()
ftp.dir directorio
list.size directorio,dsize
for a=1 to dsize
list.get directorio,a,b$
print b$
next
fn.end

fn.def get printers(n)
list.clear n
ftp.get "printers.txt","printers.txt"
text.open r,f,"printers.txt"
let a=0
do
text.readln f,line$
list.add n,line$
a=a+1
text.eof f,endyet
until endyet
list.remove n,a
text.close f
file.delete ff,"printers.txt"
fn.end

fn.def showlist(n)
list.size n,f
for a=1 to f
list.get n,a,f$
print f$
next
fn.end

fn.def setname(a)%a is or 1 depending on access
!return username, even if it means making a new username.txt
file.exists hay,"username.txt"
if hay
text.open r,f,"username.txt"
text.readln f,line$
else
do
input "Looks like you're new. Do you mind picking a username?",line$
nottaken=1
until nottaken
!make a new username.txt file
text.open w,f,"username.txt"
line$=line$+using$("","%d",int(a))
text.writeln f,line$
text.close f
endif
list.create s,b
list.add b,line$
fn.rtn b
fn.end
! ------END FXS------

dim a$[2]
a$[1]="I use printers"
a$[2]="I'm in charge of a printer"
dim b$[2]
b$[1]="See printers"
b$[2]="Request a change"




!------END DATA------

ftp.open "drakeliu.hostedftp.com",21,"redscare3", "redscare3"
list.create s,plist


dialog.select choice0,a$[],"Please choose what describes you best:?"
if choice0=2
input "Please input the CSC password:",passtry$
ftp.get "password.txt","password.txt"
text.open r,f,"password.txt"
text.readln f,correct$
text.close f
file.delete a,"password.txt"
if passtry$=correct$
let b=setname(1)
list.get b,1,username$
print "Im a csc"
print username$
else %if csc has no access
print "Wrong password."
endif %pa csc w access
else %pa if ur not a csc
!normal person:
let b=setname(0)
list.get b,1,username$
print username$
do
dialog.select choice2,b$[],"What would you like to do?"
if choice2=1 %show print
getprinters(plist)
showlist(plist)
pause 3000
else %request
input "Type request:",r$
print r$
text.open w,f,username$+".txt"
text.writeln f,r$
text.close f
ftp.put username$+".txt",username$+".txt"
file.delete fff,username$+".txt"
endif
until 0 %end normal user
endif