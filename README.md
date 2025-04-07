# Percona Centralized Automation - Debian Package

This document outlines the steps to build, run, and utilize the `deb` package for server metric collection via Jenkins.

## Prerequisites

* Docker installed on your system.
* A web browser.
* Basic understanding of Jenkins and Debian package management.

## Installation and Setup

1.  **Build the Docker Image:**
    * Navigate to the directory containing the `Dockerfile` from this repository.
    * Execute the following command to build the Docker image:

        ```bash
        docker build --no-cache -t my-jenkins-debian .
        ```

        * `--no-cache`: Ensures a fresh build, avoiding potential caching issues.
        * `-t my-jenkins-debian`: Tags the image with the name `my-jenkins-debian`.

2.  **Run the Jenkins Container:**
    * Run the Docker container from the newly built image:

        ```bash
        docker run -d --name debian-jenkins -p 8080:8080 my-jenkins-debian
        ```

        * `-d`: Runs the container in detached (background) mode.
        * `--name debian-jenkins`: Assigns the name `debian-jenkins` to the container.
        * `-p 8080:8080`: Maps port 8080 on your host machine to port 8080 in the container, allowing access to the Jenkins web interface.

3.  **Access Jenkins:**
    * Open your web browser and navigate to `http://localhost:8080`.
    * Log in using the default credentials:
        * **User ID:** `admin`
        * **Password:** `admin@123`

4.  **Build the `collect` Job Pipeline:**
    * In Jenkins, configure and build the "collect" job pipeline. This pipeline will generate the `collect-info_1.0_all.deb` package.

## Package Installation and Execution

1.  **Install the Debian Package:**
    * After the Jenkins pipeline successfully builds the DEB package, install it on your target Debian-based system using:

        ```bash
        sudo dpkg -i collect-info_1.0_all.deb
        ```

        * `sudo`: Provides administrator privileges.
        * `dpkg`: The package manager for Debian and similar distributions.
        * **Note:** For automatic dependency resolution, `sudo apt install ./collect-info_1.0_all.deb` is recommended.

2.  **Run the `collect_data.sh` Script:**
    * Execute the `collect_data.sh` script to collect server metrics:

        ```bash
        collect_data.sh
        ```

3.  **View Metrics:**
    * The collected metrics will be stored in the `final_output` directory within this repository.
    * Customize the collected metrics as needed by modifying the `collect_data.sh` script.

## Notes

* Ensure Docker is running before executing the `docker run` command.
* Modify the Jenkins pipeline and `collect_data.sh` script to suit your specific metric collection requirements.
* For persistent Jenkins data, consider using Docker volumes.
* Using `apt` to install the deb file will resolve dependencies automatically.