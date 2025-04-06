## Percona-centralised-automation
## For Debian-package

Steps to follow.

1. Build and run the dockerfile present in the git repo.
   Steps to build and run the Dockerfile :-
   a. docker build --no-cache -t my-jenkins-debian . :- This will build the dockerfile as an image.
   b. docker run -d --name debian-jenkins -p 8080:8080 my-jenkins-rpm :- This will run as a container.
2. Type http://localhost:8080, in the web browser after executing the above steps to get into the Jenkins locally.
3. User Id and password for Jenkins is “admin/admin@123”
4. Build the deb_package job pipeline to get the [collect-info_1.0_all.deb] package.
5. To run above package, exceute "sudo dpkg -i collect-info_1.0_all.deb"
6. Execute collect_data.sh command
7. Finally we can see metrics of the server and choose the metrics that we need.