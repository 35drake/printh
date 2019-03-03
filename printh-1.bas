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

dim a$[2]
a$[1]="I use printers"
a$[2]="I'm in charge of a printer"

ftp.open "drakeliu.hostedftp.com",21,"redscare3", "redscare3"

fn.def showdir()
ftp.dir directorio
list.size directorio,dsize
for a=1 to dsize
list.get directorio,a,b$
print b$
next
fn.end


dialog.select choice0,a$[],"Please choose what describes you best:?"
if choice0=2
input "Please input the CSC password:",passtry$
ftp.get "password.txt","password.txt"
text.open r,f,"password.txt"
text.readln f,correct$
text.close f
file.delete a,"password.txt"
if passtry$=correct$


print 6

else %if csc has no access
print "Wrong password."
endif %pa csc w access
endif %pa cscs