# Percona Centralized Automation - Jenkins Setup and Execution

This document outlines the steps to clone the automation repository, build and run the Jenkins Docker container, and access the Jenkins instance.

## Prerequisites

* Git installed on your system.
* Docker installed on your system.
* A web browser.
* Basic understanding of Jenkins, Deb and Rpm related packages.

## Steps

1.  **Clone the Git Repository:**
    * Open your terminal and navigate to the directory where you want to clone the repository.
    * Execute the following command, replacing `<repository_url>` with the actual URL of your Git repository:

        ```bash
        git clone <repository_url>
        ```

        * Example: `git clone https://github.com/percona/percona-centralized-automation.git`

2.  **Navigate to the Repository Folder:**
    * Once the repository is cloned, change your current directory to the newly created repository folder:

        ```bash
        cd percona-centralized-automation
        ```

        * Replace `percona-centralized-automation` with the actual name of the cloned repository folder if it's different.

3.  **Build the Jenkins Docker Image:**
    * Ensure you are inside the repository folder containing the `Dockerfile`.
    * Execute the following command to build the Docker image:

        ```bash
        docker build --no-cache -t my-jenkins-image .
        ```

        * `--no-cache`: Ensures a fresh build, avoiding potential caching issues.
        * `-t my-jenkins-image`: Tags the image with the name `my-jenkins-image`. **Note:** Adjust the image name if your previous instructions used a different name (e.g., `my-jenkins-rpm` or `my-jenkins-debian`).

4.  **Run the Jenkins Container:**
    * Run the Docker container from the newly built image:

        ```bash
        docker run -d --name jenkins-server -p 8080:8080 my-jenkins-image
        ```

        * `-d`: Runs the container in detached (background) mode.
        * `--name jenkins-server`: Assigns the name `jenkins-server` to the container. You can choose a different name if desired (e.g., `rpm-jenkins` or `debian-jenkins` to align with your specific package type).
        * `-p 8080:8080`: Maps port 8080 on your host machine to port 8080 in the container, allowing access to the Jenkins web interface.
        * `my-jenkins-image`: Use the same image name you used in the `docker build` step.

5.  **Access Jenkins:**
    * Open your web browser and navigate to `http://localhost:8080`.
    * Log in using the default credentials (if applicable, based on your Dockerfile configuration):
        * **User ID:** `admin`
        * **Password:** `admin@123`

## Next Steps (Example - Adjust based on your actual workflow)

* **Configure Jenkins:** Set up necessary plugins, credentials, and build jobs within the Jenkins web interface.
* **Build Package Job:** Create a Jenkins pipeline or job to build your RPM or DEB package (e.g., `collect_data-1.0-1.noarch.rpm` or `collect-info_1.0_all.deb`).
* **Install Package:** Once the package is built by Jenkins, you would typically transfer it to your target machine and install it using `sudo dnf install <package_name>.rpm` (for RPM) or `sudo apt install ./<package_name>.deb` (for DEB).
* **Execute Script:** Run the `collect_data.sh` script (or a similar script provided by your package) on the target machine.
* **View Metrics:** Analyze the collected metrics in the designated final output directory.

## Notes

* Ensure Git and Docker are installed and running on your system.
* Replace `<repository_url>` with the actual URL of your Git repository.
* Adjust the Docker image and container names as needed to maintain consistency with your workflow.
* Refer to the specific documentation within your repository for details on the Jenkins pipeline, package building process, and the `collect_data.sh` script.