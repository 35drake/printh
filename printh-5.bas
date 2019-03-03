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

fn.def eastfrac(a)
fn.rtn (a+118.291571)/(118.291571-118.280688)
fn.end

fn.def fraceast(a)
fn.rtn a*(118.291571-118.280688)-118.291571
fn.end

fn.def northfrac(a)
fn.rtn (a-34.026160)/(-34.026160+34.018233)
fn.end

fn.def fracnorth(a)
fn.rtn a*(-34.026160+34.018233)+34.026160
fn.end

fn.def fraclength(l,a)
fn.rtn (0.1+0.5*a)*l
fn.end

fn.def lengthfrac(l,a)
fn.rtn (a/l-0.1)/0.5
fn.end

fn.def nearest(longlist,latlist,east,north)
best=0
distance=10000
list.size longlist,f
for ff=1 to f
list.get longlist,ff,a
list.get latlist,ff,b
newdistance=pow(pow(a-east,2)+pow(b-north,2),1/2)
if newdistance<distance
distance=newdistance
best=ff
endif
next
fn.rtn best
fn.end

fn.def request(short$,username$,old$,good)
let old$=right$(old$,28)
text.open w,f,username$+".txt"
time year$,month$,day$,,,,,
let day=(val(year$)-2000)*10000+val(month$)*100+val(day$)
let ff=time()
let f$=USING$(, "%tT", int(ff))
let time$=left$(f$,2)+right$(left$(f$,5),2)
if right$(username$,1)="0"
old$=left$(old$,14)
text.writeln f,short$+old$+" "+using$("","%d",int(good))+" "+using$("","%d",int(day))+" "+time$
else
old$=right$(old$,14)
text.writeln f,short$+" "+using$("","%d",int(good))+" "+using$("","%d",int(day))+" "+time$+old$
endif
text.close f
ftp.put username$+".txt",username$+".txt"
file.delete fff,username$+".txt"
fn.end



! ------END FXS------

dim a$[2]
a$[1]="I use printers"
a$[2]="I'm in charge of a printer"
dim b$[2]
b$[1]="See printers"
b$[2]="Request a change"

list.create s,plist

list.create s,namelist1
list.add namelist1,"NWN"
list.add namelist1,"MCR:
list.add namelist1,"CAL"
list.add namelist1,"IRC"
list.add namelist1,"PAH"
list.add namelist1,"MKS"
list.add namelist1,"BKT"

list.add namelist1,"TJH"
list.add namelist1,"PDE"
list.add namelist1,"NMV"
list.add namelist1,"COW"
list.add namelist1,"WEB"
list.add namelist1,"FLR"
list.add namelist1,"MLM"

list.create s,namelist2
list.add namelist2,"New North"
list.add namelist2,"McCarthy"
list.add namelist2,"Cale and Irani"
list.add namelist2,"Parkside IRC"
list.add namelist2,"Parkside A&H"
list.add namelist2,"Marks Tower"
list.add namelist2,"Birnkrant"

list.add namelist2,"Trojan Hall"
list.add namelist2,"Pardee Tower"
list.add namelist2,"Nemirovsky"
list.add namelist2,"Cowlings and Ilium"
list.add namelist2,"Webb Tower"
list.add namelist2,"Fluor Tower"
list.add namelist2,"Prof. Malmstadt's Office"

list.create n,latlist
list.add latlist,34.021050
list.add latlist,34.025211
list.add latlist,34.025173
list.add latlist,0
list.add latlist,0
list.add latlist,0
list.add latlist,0

list.add latlist,0
list.add latlist,0
list.add latlist,0
list.add latlist,0
list.add latlist,0
list.add latlist,0
list.add latlist,0


list.create n,longlist
list.add longlist,-118.282085
list.add longlist,-118.285726
list.add longlist,-118.285691
list.add longlist,0
list.add longlist,0
list.add longlist,0
list.add longlist,0

list.add longlist,0
list.add longlist,0
list.add longlist,0
list.add longlist,0
list.add longlist,0
list.add longlist,0
list.add longlist,0






!------END DATA------
ftp.open "drakeliu.hostedftp.com",21,"redscare3", "redscare3"





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
gps.open gpsworked
do
getprinters(plist)




until 0 %end normal user
endif