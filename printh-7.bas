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

fn.def getprinters(n)
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

fn.def makename()
dim a$[2]
a$[1]="I use printers"
a$[2]="I'm in charge of a printer"
dialog.select gg,a$[],"Looks like you're new. Which describes you best?"
if gg=2
do
input "Please input the CSC password:",passtry$
ftp.get "password.txt","password.txt"
text.open r,f,"password.txt"
text.readln f,correct$
text.close f
file.delete a,"password.txt"
until passtry$=correct$
endif
do
input "Do you mind picking a username?",line$
!check if taken
nottaken=1
until nottaken
!make a new username.txt file
text.open w,f,"username.txt"
line$=line$+using$("","%d",int(gg=2))
text.writeln f,line$
text.close f
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

!nur used pa auto gps suggestion
fn.def nearlist(longlist,latlist,east,north)
list.size longlist,f
list.create n,list1
list.create n,list2
for ff=1 to f
list.add list1,ff
list.get longlist,ff,a
list.get latlist,ff,b
list.add list2,pow(pow(a-east,2)+pow(b-north,2),1/2)
next
do
notdone=0
for ff=1 to f-1
list.get list2,ff,a
list.get list2,ff+1,b
if b<a
list.get list1,ff,c
list.get list1,ff+1,d
list.replace list2,ff,b
list.replace list2,ff+1,a
list.replace list1,ff,d
list.replace list1,ff+1,c
!switch both lists
notdone=1
endif
next
until notdone=0
fn.rtn list1
fn.end

!nur pa user touches
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

fn.def maingood(plist,f)
list.get plist,f,ff$
fn.rtn "1"=right$(left$(ff$,5),1)
fn.end

!pinpointers[1]=marksize(w,l,latlist,longlist,m)
fn.def marksize(w,l,latlist,longlist,green,small,point,f)
gr.hide point
if green
gr.bitmap.load f0,"green.png"
else
gr.bitmap.load f0,"red.png"
endif
if small
gr.bitmap.scale f1,f0,w/25,w/25
else
gr.bitmap.scale f1,f0,w/10,w/10
endif
list.get latlist,f,thislat
list.get longlist,f,thislong
let one=w*eastfrac(thislong)
if small
gr.bitmap.draw f2,f1,one-w/50,fraclength(l,northfrac(thislat))-w/25
else
gr.bitmap.draw f2,f1,one-w/20,fraclength(l,northfrac(thislat))-w/10

endif
fn.rtn f2
fn.end



! ------END FXS------

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


list.size longlist,numhouse
dim pinpointers[numhouse]



!------END DATA------
ftp.open "drakeliu.hostedftp.com",21,"redscare3", "redscare3"
file.exists iam,"username.txt"
if iam
text.open r,f,"username.txt"
text.readln f,username$
text.close f
else
makename()
endif

text.open r,f,"username.txt"
text.readln f,username$
text.close f


if right$(username$,1)="1"
!csc stuff
else
!normal person:
gps.open gpsworked
let sel=0
if gpsworked
gps.latitude lats
gps.longitude longs
!make sel nearest working place
endif
getprinters(plist)
gr.open 255,0,0,0
gr.orientation 1
gr.screen w,l
gr.bitmap.load bm0,"map.jpg"
gr.bitmap.scale bm,bm0,w,l/2
gr.bitmap.draw bmg,bm,0,l*0.1
gr.render
for f=1 to numhouse
if maingood(plist,f)
gr.bitmap.load f0,"green.png"
else
gr.bitmap.load f0,"red.png"
endif
gr.bitmap.scale f1,f0,w/25,w/25 %change
list.get latlist,f,thislat
list.get longlist,f,thislong
gr.bitmap.draw f2,f1,w*eastfrac(thislong)-0.01*w,fraclength(l,northfrac(thislat))-0.01*w
let pinpointers[f]=f2
next
let orderd=nearlist(longlist,latlist,longs,lats)
let f=0
nice=0
do
f=f+1 %f is only index or ordered list
list.get orderd,f,h
if maingood(plist,h)
let pinpointers[h]=marksize(w,l,latlist,longlist,maingood(plist,h),0,pinpointers[h],h)
sel=h
nice=1
endif
until nice
gr.render


pause 5000


do

until 0 %end normal user
endif

