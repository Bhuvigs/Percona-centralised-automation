## Percona-centralised-automation
## For rpm-package


Note: Prerequiste
1. gum should be installed first to run the application.


Steps to follow.

1. Build and run the dockerfile present in the git repo.
2. Type http://localhost:8080, in the web browser after executing the step 1 to get into the Jenkins locally.
3. User Id and password for Jenkins is “admin/admin@123”
4. Build the collect job pipeline to get the collect_data-1.0-1.noarch.rpm.
5. To run above package, exceute "sudo dnf install collect_data-1.0-1.noarch.rpm"
6. Execute collect_data
7. Finally we can see metrics of the server.
