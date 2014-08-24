run_analysis <- function(directory="UCI HAR Dataset"){
        ##modify directory in case backslash was included
        directory <- gsub("/","",directory)
        
        ## use provided directory to designate subject file from train group
        file<-paste(directory,"/train/subject_train.txt",sep = "")
        
        ## create subject_train dataframe for labels
        subject_train <- read.table(file,col.names=c("subject"))
        
        ##designate subject as train group
        subject_train$group <- "train"
        
        ## add index to subject_train
        st_index <- seq(1:nrow(subject_train))
        subject_train$index <- st_index
        
        ## designate activity file for reading
        activity_file<-paste(directory,"/train/y_train.txt",sep = "")
        
        ## create activity dataframe for train group
        activity_train <- read.table(activity_file,col.names=c("activity"))
        
        ## add index to activity_train
        at_index <- seq(1:nrow(activity_train))
        activity_train$index <- at_index
        
        ## merge subject_train and activity_train dataframes
        sub_act_train <- merge(subject_train,activity_train,by="index")
        
        ## designate file to read features for variables
        features_file = paste(directory,"/features.txt",sep = "")
        ##create features dataframe and reas as vector
        features <- read.table(features_file,col.names=c("index","varname"), stringsAsFactors = FALSE)
        ## restructure variable names
        for (i in 1:nrow(features)){
                ## remove parenthesis and dash
                features[i,2] <- gsub("\\(\\)-","_",features[i,2])
                
                ## remove parenthesis without dash
                features[i,2] <- gsub("\\(\\)","",features[i,2])
                
                ## remove parenthesis without dash
                features[i,2] <- gsub("\\(","_",features[i,2])
                
                ## remove parenthesis without dash
                features[i,2] <- gsub("\\)","",features[i,2])
                
                ## remove parenthesis without dash
                features[i,2] <- gsub(",","_",features[i,2])
                
                ## replace dashes with underscores
                features[i,2] <- gsub("-","_",features[i,2])
                
                ## replace start of reading with description
                features[i,2] <- gsub("tB","time_b",features[i,2])
                
                features[i,2] <- gsub("tG","time_g",features[i,2])
                
                features[i,2] <- gsub("fB","frequency_b",features[i,2])
        }
        ## create vector to use as variable names
        featuresV <- as.vector(features[ ,2])
        
        ## designate file for train group data vectors
        train_file <- paste(directory,"/train/X_train.txt",sep = "")
        
        ## create dataframe for train data
        train_train <- read.table(train_file,col.names = featuresV)
        
        ## add index to train data dataframe
        train_index <- seq(1:nrow(train_train))
        train_train$index <- train_index
        
        ## merge subjects and activities with data
        train_df <- merge(sub_act_train,train_train, by = "index")

        ## BEGIN WORK ON TEST GROUP
        
        ## use provided directory to designate subject file from test group
        file<-paste(directory,"/test/subject_test.txt",sep = "")
        
        ## create subject_test dataframe for labels
        subject_test <- read.table(file,col.names=c("subject"))
        
        ##designate subject as test group
        subject_test$group <- "test"
        
        ## add index to subject_test
        st_index <- seq(1:nrow(subject_test))
        subject_test$index <- st_index
        
        ## designate activity file for reading
        activity_file<-paste(directory,"/test/y_test.txt",sep = "")
        
        ## create activity dataframe for test group
        activity_test <- read.table(activity_file,col.names=c("activity"))
        
        ## add index to activity_test
        at_index <- seq(1:nrow(activity_test))
        activity_test$index <- at_index
        
        ## merge subject_test and activity_test dataframes
        sub_act_test <- merge(subject_test,activity_test,by="index")
        
        ## designate file to read features for variables
        features_file = paste(directory,"/features.txt",sep = "")
        ##create features dataframe and reas as vector
        features <- read.table(features_file,col.names=c("index","varname"), stringsAsFactors = FALSE)
        ## restructure variable names
        for (i in 1:nrow(features)){
                ## remove parenthesis and dash
                features[i,2] <- gsub("\\(\\)-","_",features[i,2])

                ## remove parenthesis without dash
                features[i,2] <- gsub("\\(\\)","",features[i,2])

                ## remove parenthesis without dash
                features[i,2] <- gsub("\\(","_",features[i,2])

                ## remove parenthesis without dash
                features[i,2] <- gsub("\\)","",features[i,2])
                
                ## remove parenthesis without dash
                features[i,2] <- gsub(",","_",features[i,2])
                
                ## replace dashes with underscores
                features[i,2] <- gsub("-","_",features[i,2])
                
                ## replace start of reading with description
                features[i,2] <- gsub("tB","time_b",features[i,2])
                
                features[i,2] <- gsub("tG","time_g",features[i,2])
                
                features[i,2] <- gsub("fB","frequency_b",features[i,2])
                
        }
        ##create vector to use as variable names
        featuresV <- as.vector(features[ ,2])
        
        ## designate file for test group data vectors
        test_file <- paste(directory,"/test/X_test.txt",sep = "")
        
        ## create dataframe for test data
        test_test <- read.table(test_file,col.names = featuresV)
        
        ## add index to test data dataframe
        test_index <- seq(1:nrow(test_test))
        test_test$index <- test_index
        
        ## merge subjects and activities with data
        test_df <- merge(sub_act_test,test_test, by = "index")
        
        ## merge the train dataframe and test dataframe together
        complete_df <- rbind(train_df,test_df)
        
        ## create vector to return
        varlist1 <- c("index","subject","activity")
        varlist2 <- NULL
        
        ## look for mean and std in variable title and create vector for selecting variables
        for(i in 1:nrow(features)){
                meanthere <- grepl("mean",features[i,2],ignore.case=TRUE)
                if(meanthere == TRUE){
                        varlist2<-cbind(varlist2,features[i,2])
                }
                stdthere <- grepl("mean",features[i,2],ignore.case=TRUE)
                if(stdthere == TRUE){
                        varlist2<-cbind(varlist2,features[i,2])
                }
                
        }
        
        ## create final column select list for tidy_1
        varlist <- c(varlist1,varlist2)
        
        tidy_1 <- subset(complete_df,subset = index > 0, select = c(varlist))

        ## create empty dataframe for means
        ##tidy_2 <- data.frame(c(varlist),0)
        
        sub_1 <- subset(tidy_1, subset = subject == 1&activity == 1)
        sub_1Means<- lapply(sub_1,2,FUN=mean)
        
        ## create empty dataframe for means
        newtidy <- as.data.frame(sub_1Means)
        ##correct for proper variables
        tidy_2 <- newtidy[c(-1),]
        
        ## assign variable means to new dataframe
        for(i in 1:30){
                for(j in 1:6){
                        sub_1 <- subset(tidy_1, subset = subject == i&activity == j)
                        sub_1Means <- sapply(sub_1,2,FUN=mean)
                        
                        tidy_2 <- rbind(tidy_2,sub_1Means)
                        
                }
        }
        
        for(i in 1:ncol(tidy_2)){
                names(tidy_2)[i] <- varlist[i]
        }
        
        ## match activity code with readable activity
         for(i in 1:nrow(tidy_2)){
                if(tidy_2[i,3]==1){ tidy_2[i,3] = "WALKING"}
                if(tidy_2[i,3]==2){ tidy_2[i,3] = "WALKING_UPSTAIRS"}
                if(tidy_2[i,3]==3){ tidy_2[i,3] = "WALKING_DOWNSTAIRS"}
                if(tidy_2[i,3]==4){ tidy_2[i,3] = "SITTING"}
                if(tidy_2[i,3]==5){ tidy_2[i,3] = "STANDING"}
                if(tidy_2[i,3]==6){ tidy_2[i,3] = "LAYING"}
        }
        
        ## edit index
        t1 <- seq(1:nrow(tidy_2))
        tidy_2$index <- t1
        
        write.table(tidy_2, file = "tidy_means_stds.txt", append = FALSE, quote = TRUE, sep = " ",
                    eol = "\n", na = "NA", dec = ".", row.names = TRUE,
                    col.names = TRUE, qmethod = c("double"),
                    fileEncoding = "")
        return(tidy_2)
}
