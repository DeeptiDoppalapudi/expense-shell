#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#echo "Please enter DB PWD"
#read -s mysql_root_password

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling default nodeJS"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling nodejs:20 Version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Installing Node JS"

#useradd expense
#VALIDATE $? "Creating User"

id expense -y &>>$LOGFILE
if [$? -ne 0]
then
useradd expense -y &>>$LOGFILE
VALIDATE $? "Creating Expense User"
else
echo "expense user already exists.. $Y SKIPPING $N"
fi









