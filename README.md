## Percona-centralised-automation
## For Debian-package


Note: Prerequiste
1. gum should be installed first to run the application.


Steps to follow.

1. Build and run the dockerfile present in the git repo.
2. Type http://localhost:8080, in the web browser after executing the step 1 to get into the Jenkins locally.
3. User Id and password for Jenkins is “admin/admin@123”
4. Build the deb_package job pipeline to get the collect-info_1.0_all.deb package.
5. To run above package, exceute "sudo dpkg -i collect-info_1.0_all.deb"
6. Execute collect_data.sh 
7. Finally we can see metrics of the server.
