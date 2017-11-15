amazonlinux-numpy-lambda
========================

This is a wrapper of the amazonlinux-2017.09 docker image that can be used to package and deploy 
Python3.6 lambda functions that use pandas and/or numpy. 

Summary
-------
When running lambda functions, you need to create a package containing all the requirements for the function. If you are using numpy or pandas for data science, you will need to compile these libraries in the same OS they are going to be running (amazonlinux). 

This image contains python3.6, pip3 numpy and 
pandas pre-installed to reduce build and deployment times. Nodejs is also installed in oder to use deployment tools like the [Serverless Framework](https://serverless.com/). 

Install
-------
```bash
docker run -t -d -v /path/to/code:/app onema/amazonlinux4lambda:latest
```


Reference
---------
- [Using NumPy and Pandas on AWS Lambda](https://streetdatascience.com/2016/11/24/using-numpy-and-pandas-on-aws-lambda/)
- [Amazon Linux Docker Images](https://github.com/aws/amazon-linux-docker-images/tree/2017.09)
