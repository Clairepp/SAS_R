# HW 6
# Problem 1
# 1.
＃ the integer class
# 2.
# the first number is added with semicolon, becuase the original data has the comma in itself
# the consequence of the change is that the number has the comma in it, and it is special format.
# 3.
gss.abbrev <- read.csv("~/Downloads/GSS_1996_abbrev.csv", na.strings = ".")
gss.abbrev[1:10,]  # look at the first 10 rows # if we had ommitted the na.strings = '.' option, the missing value '.' will not become 'NA'.
# header = TRUE, then the variables' names are the first row of the file. Otherwise, the variables' names are 'var1','var2',...
# 4.
sex <- gss.abbrev$sex
class(sex)
# integer
# 5.
gss.abbrev$sex <- factor(gss.abbrev$sex, labels = c("Male","Female"))
gss.abbrev$race <- factor(gss.abbrev$race, labels = c("White","Black","Other (specify)"))
# it is appropriate, because the meanings for "1 ~ 9" is appropriate for ordered.
gss.abbrev$race <- factor(gss.abbrev$childs, labels = c("None","One","Two","Three","Four","Five","Six","Seven","Eight or more","No answer"))
# Problem 2
# 1.
n = seq(1:24)
arr <- array(1:24, dim = c(2, 4, 3))
arr.sum <- apply(arr,c(1,2),sum)
arr.sum[2,1]
# 30
# 2.
vec <- c(1,rep(2,each = 2),rep(3,each =3),rep(4,each =4),rep(5,each=5),rep(6,each=6),rep(7,each=7),rep(8,each=8),rep(9,each=9),rep(10,each=10))
vec[10:20]
vec[seq(5,length(vec),by=5)]
vec[vec %in% c(8)] <- 88
which(vec == 8) 
vec[vec %in% c(8)] <- vec[which(vec == 8) - 1]
match(3,vec)
# 4
match(9,vec)
# 37
# 3.
# (a)
maint <- c("medium", "medium", "low", "high", "high", "high", "medium", "high", "low")
# (b)
maint.fac <- factor(maint)
maint.fac<- factor(maint.fac, levels = c("low","medium","high","very high"))
maint.tab <- table(maint.fac)
as.numeric(maint.tab)
# (c)
costs <- c(100,200,400,1000)
names(costs)<-c("low","medium","high","very high")
# (d)
m <- matrix(costs)
c <- matrix(maint.tab,nrow=1,ncol=4)
t <- c %*% m
# 2400
# (e)
t1 <- m %*% c
portfoil.sum1 <- sum(t1[1,1],t1[2,2],t1[3,3])
# 2400
# (f)
portfoil.sum2 <- sum(t1[1,1],t1[2,2])
# 800
# Problem 3
# 1.
getwd() # too see where your current working directory is
load("HW6.RData") # load the objects into your workspace
ls() # to see all the objects in your workspace
n <- length(FinalExam)
# There are 566 students in the class
# 2.
fianl.fail <- FinalExam[FinalExam < 60]
n1 <- length(fianl.fail)
# 15.02 percentage of students had a course average of less than 60%
# 3.
not.enter <- FinalExam[FinalExam == 0]
length(not.enter)
# five students did not take the final exam.
# 4.
mean.quiz <- mean(Quiz)
percentage1 <- mean.quiz/45
# 86.10%
mean.midterm <- mean(Midterm)
percentage2 <- mean.midterm/100
# 73.92%
mean.final <- mean(FinalExam)
percentage3 <- mean.final/100
# 71.38%
# 5.
stu <- which(Midterm >= 80 & Quiz <= 70)
length(stu)
# 232
# So there are 232 students who had a midterm score of at least 80% and also a quiz score of no more than 70%
# 6.
stu1 <- which(CourseAvg < FinalExam)
length(stu1)
# 46
# so the percentage for students whose course average was lower than their final exam score is 8.13%
# 7.
stu2.final <- FinalExam[which(Homework == 200)]
max(stu2.final)
# 100
So the maximum value is 100
# 8. 
stu3.home <- Homework[which(CourseAvg > 85)]
min(stu3.home)
# 186
# the lowest homework score among all students who finished with a course average greater than 85% is 186.