## Percona-centralised-automation
## For rpm-package

Steps to follow.

1. Build and run the dockerfile present in the git repo.
   Steps to build and run the Dockerfile :-
   a. docker build --no-cache -t my-jenkins-rpm . :- This will build the dockerfile as an image.
   b. docker run -d --name rpm-jenkins -p 8080:8080 my-jenkins-rpm :- This will run as a container.
2. Type http://localhost:8080, in the web browser after executing the above steps to  get into the Jenkins locally.
3. User Id and password for Jenkins is “admin/admin@123”
4. Build the deb_package job pipeline to get the [collect_data-1.0-1.noarch.rpm] package.
5. To run above package, exceute "sudo dnf install collect_data-1.0-1.noarch.rpm"
6. Execute collect_data.sh command
7. Finally we can see metrics of the server and choose the metrics that we need.
