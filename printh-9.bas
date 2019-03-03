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
distance=1000000
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

!pinpointers[1]=marksize(pinpointers[1],w,l,latlist,longlist,m)
fn.def marksize(dell,w,l,latlist,longlist,green,small,point,f)
gr.hide dell
!gr.bitmap.delete dell
if green
gr.color 255,0,255,0
else
gr.color 255,255,0,0
endif
!small=1
list.get latlist,f,thislat
list.get longlist,f,thislong
let one=w*eastfrac(thislong)
let two=fraclength(l,northfrac(thislat))
let space=40-20*small
gr.rect f2,one-space,two-space,one+space,two+space
fn.rtn f2
fn.end

fn.def top(namelist2,w,l,top,a)
gr.hide top
gr.color 255,255,255,255
gr.text.size 80
gr.text.align 1
gr.text.bold 0
list.get namelist2,a,b$
gr.text.draw top,0.015*w,0.06*l,b$
gr.show top
fn.rtn top
fn.end

fn.def sub(namelist1,w,l,sub,a)
gr.hide sub
gr.color 255,255,255,255
gr.text.size 30
gr.text.align 3
gr.text.bold 1
list.get namelist1,a,b$
gr.text.draw sub,0.94*w,0.09*l,b$
fn.rtn sub
fn.end

fn.def mid(plist,w,l,mid,a)
gr.hide mid
list.get plist,a,hi$
if right$(left$(hi$,5),1)="1"
gr.color 255,70,180,230,1
else
gr.color 255,170,89,20,1
endif
!gr.color 255,0,150,255,1
gr.text.size 60
gr.text.align 1
gr.text.bold 1
!let old$=right$
!text.open w,f,username$+".txt"
time year$,month$,day$,,,,,
let myday=(val(year$)-2000)*10000+val(month$)*100+val(day$)
let ff=time()
let f$=USING$(, "%tT", int(ff))
print f$
myminutes=val(right$(left$(f$,5),2))
myhour=val(left$(f$,2))
myyear=val(year$)-2000
mymonth=val(month$)
myday=val(day$)
list.get plist,a,ff$
print myminutes
print right$(left$(ff$,17),2)
!end
!if myminutes>val(right$(left$(ff$,17),2))
here=myminutes-val(right$(left$(ff$,17),2))
if here<0
here=here+60
endif
b$="Checked "+using$("","%d",int(here))+" minutes ago"
gr.text.draw mid,0.03*w,0.68*l,b$
fn.rtn mid
fn.end


fn.def bot(plist,w,l,bot,a)
list.get plist,a,hi$
gr.hide bot
if right$(left$(hi$,19),1)="1"
gr.color 255,100,207,200,1
else
gr.color 255,230,49,200,1
endif
gr.text.size 60
gr.text.align 1
gr.text.bold 1
!let old$=right$
!text.open w,f,username$+".txt"
time year$,month$,day$,,,,,
let myday=(val(year$)-2000)*10000+val(month$)*100+val(day$)
let ff=time()
let f$=USING$(, "%tT", int(ff))
print f$
myminutes=val(right$(left$(f$,5),2))
myhour=val(left$(f$,2))
myyear=val(year$)-2000
mymonth=val(month$)
myday=val(day$)
list.get plist,a,ff$
print myminutes
print right$(left$(ff$,17),2)
!end
!if myminutes>val(right$(left$(ff$,17+14),2))
here=myminutes-val(right$(left$(ff$,17+14),2))
if here<0
here=here+60
endif
b$="Checked "+using$("","%d",int(here))+" minutes ago"
gr.text.draw mid,0.03*w,0.82*l,b$
gr.render
fn.rtn mid
fn.end





dim b$[2]
b$[1]="See printers"
b$[2]="Request a change"

dim do$[2]
let do$[1]="Ok"
let do$[2]="Cancel"

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
list.add namelist2,"Prof. Malmstadt"

list.create n,latlist
list.add latlist,34.021050
list.add latlist,34.025211
list.add latlist,34.025173
list.add latlist,34.019107
list.add latlist,34.018664
list.add latlist,34.019811
list.add latlist,34.021468

list.add latlist,34.019308
list.add latlist,34.020075
list.add latlist,34.025349
list.add latlist,34.025783
list.add latlist,34.024593
list.add latlist,34.034824
list.add latlist,34.020016


list.create n,longlist
list.add longlist,-118.282085
list.add longlist,-118.285726
list.add longlist,-118.285691
list.add longlist,-118.291035
list.add longlist,-118.289424
list.add longlist,-118.282195
list.add longlist,-118.282335

list.add longlist,-118.282215
list.add longlist,-118.282689
list.add longlist,-118.284684
list.add longlist,-118.284248
list.add longlist,-118.28783
list.add longlist,-118.288368
list.add longlist,-118.289944


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
list.toarray namelist2,v$[]
dialog.select choice8,v$[],"Which building are you in?"
do
gr.open 255,0,0,0
gr.orientation 1
gr.screen w,l
for a=1 to w
gr.color 255,200,200+50*(a/w),230-19*(a/w)
gr.line n,a,0,a,l
next
gr.color 100,255,0,0
gr.rect n,w/5,l/10,w*4/5,l*4/10
gr.color 100,0,255,100
gr.rect n,w/5,l*6/10,4*w/5,l*9/10
gr.color 255,0,00,040
gr.text.size 50
gr.text.bold 1
gr.text.draw n,w/40,l/20,"Signed in as: "+username$
gr.text.align 3
gr.text.size 25
gr.text.align 1
gr.text.draw n,w/50,l*49/50,"Reset"
gr.text.underline 1
gr.text.size 30
gr.text.align 3
gr.text.draw n,w*19/20,l/20,v$[choice8]
gr.render
getprinters(plist)
list.get plist,choice8,gf$
do
do
gr.touch flag,x,y
until flag
if x>w/5 & x<w*4/5 & y>l/10 & y<4*l/10
call request(left$(gf$,3),username$,gf$,0)
gr.color 130,95,30,30
gr.rect n,w/5,l/10,w*4/5,l*4/10
gr.render
pause 300
gr.hide n
gr.render
endif
if x>w/5 & x<w*4/5 & y>6/10 & y<9*l/10
call request(left$(gf$,3),username$,gf$,1)
gr.color 130,30,95,30
gr.rect n,w/5,6*l/10,w*4/5,l*9/10
gr.render
pause 300
gr.hide n
gr.render
endif
if x<w/10 &y>9/10
dialog.select goo,do$[],"Delete user account?"
if goo=1 
file.delete f,"username.txt"
end
endif
endif
until 0
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
gr.render
!!
for f=1 to ff
let top=top(namelist2,w,l,top,f)
gr.render
pause 2000
next
!!

for f=1 to l*2
gr.color 190,(1-f/(l*2))*255,f/(l*2)*255
gr.line n,0,f/2,w,f/2
next
gr.color 180,20,20,20
gr.rect n,0.02*w,l*0.61,0.98*w,0.75*l
gr.rect n,0.02*w,l*0.76,0.98*w,0.89*l
gr.line top,0,0,1,1 %nur init
gr.line sub,0,0,1,1
gr.line mid,0,0,1,1
gr.line bot,0,0,1,1
!gr.bitmap.load ???,"green.png"


gr.bitmap.load bm0,"map.jpg"
gr.bitmap.scale bm,bm0,w,l/2
gr.bitmap.draw bmg,bm,0,l*0.1
gr.render

gr.bitmap.load mm0,"tmail.png"
gr.bitmap.scale mm,mm0,w/4,l/10
gr.bitmap.draw mmg,mm,w*3/4,l*9/10
gr.render

gr.bitmap.load jm0,"tyes.png"
gr.bitmap.scale jm,jm0,w/4,l/10
gr.bitmap.draw jmg,jm,w*1/2,l*9/10
gr.render

gr.bitmap.load jm0,"tno.png"
gr.bitmap.scale jm,jm0,w/4,l/10
gr.bitmap.draw jmg,jm,w*1/4,l*9/10
gr.render

gr.bitmap.load jm0,"tgear.png"
gr.bitmap.scale jm,jm0,w/4,l/10
gr.bitmap.draw jmg,jm,0,l*9/10
gr.render





print numhouse
for f=1 to numhouse
!gr.bitmap.load gosh,"smallbits.png"
!pinpointers[f]=gosh
gr.set.stroke 7
if maingood(plist,f)
gr.color 255,0,255,0,0
!gr.bitmap.load f0,"green.png"
else
gr.color 255,255,0,0,0
!gr.bitmap.load f0,"red.png"
endif
!gr.bitmap.scale f1,f0,w/25,w/25 %change
list.get latlist,f,thislat
list.get longlist,f,thislong
!gr.rect f2,w*eastfrac(thislong)-0.03*w,fraclength(l,northfrac(thislat))-0.03*w
!gr.bitmap.delete pinpointers[f]

let one=w*eastfrac(thislong)
let two=fraclength(l,northfrac(thislat))
let space=40-20*1
gr.rect f2,one-space,two-space,one+space,two+space



!problem
let pinpointers[f]=f2
next
let orderd=nearlist(longlist,latlist,longs,lats)
let f=0
nice=0
do
f=f+1 %f is only index or ordered list
list.get orderd,f,h
if maingood(plist,h)
print h
let pinpointers[h]=marksize(pinpointers[h],w,l,latlist,longlist,maingood(plist,h),1,pinpointers[h],h)
sel=h
nice=1
endif
until nice

gr.color 255,0,150,255,1
gr.text.size 40
gr.text.draw n,0.5*w,0.72*l,"by the CSC."
gr.color 255,200,7,200
gr.text.draw n,0.53*w,0.86*l,"by a user."
gr.render

gr.set.stroke 2
gr.color 255,255,255,0
let top=top(namelist2,w,l,top,sel)
let sub=sub(namelist1,w,l,top,sel)
let mid=mid(plist,w,l,mid,sel)
let bot=bot(plist,w,l,bot,sel)
gr.set.stroke 9
gr.color 255,60,60,60,0
gr.circle n,w*eastfrac(longs),fraclength(l,northfrac(lats)),w/20
gr.set.stroke 4
gr.color 255,0,0,0,1
gr.render
do
do
gr.touch flag,x,y
until flag
!gr.circle n,x,y,10
gr.render
pause 1000
!pause 500
let x=x/w
let y=lengthfrac(l,y)

gr.render
!if (0.1<y & y<0.6)|1
if y<0.9
!map hit
let m=nearest(longlist,latlist,fraceast(x),fracnorth(y))
print sel
let pinpointers[sel]=marksize(pinpointers[sel],w,l,latlist,longlist,maingood(plist,sel),1,pinpointers[sel],sel)
sel=m
let pinpointers[sel]=marksize(pinpointers[sel],w,l,latlist,longlist,maingood(plist,sel),0,pinpointers[sel],sel)
top=top(namelist2,w,l,top,sel)
sub=sub(namelist1,w,l,sub,sel)
mid=mid(plist,w,l,mid,sel)
gr.render
endif
if 1.1<y
!extra bottom stuff
if x>0.25 & x<0.5
list.get plist,sel,fy$
call request(left$(fy$,3),username$,fy$,0)
endif
if x>0.5 & x<0.75
list.get plist,sel,fy$
call request(left$(fy$,3),username$,fy$,1)
endif
if x<0.25
dialog.select goo,do$[],"Delete user account?"
if goo=1 
file.delete f,"username.txt"
end
endif
endif
if x>0.75
email.send "print@printme.com","Sent from PRINTH 'SC",""
endif
endif
until 0 %end normal user
endif