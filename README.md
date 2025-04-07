# Percona Centralized Automation - RPM Package

This document outlines the steps to build, run, and utilize the `rpm` package for server metric collection via Jenkins.

## Prerequisites

* Docker installed on your system.
* A web browser.
* Basic understanding of Jenkins and RPM package management.

## Installation and Setup

1.  **Build the Docker Image:**
    * Navigate to the directory containing the `Dockerfile` from this repository.
    * Execute the following command to build the Docker image:

        ```bash
        docker build --no-cache -t my-jenkins-rpm .
        ```

        * `--no-cache`: Ensures a fresh build, avoiding potential caching issues.
        * `-t my-jenkins-rpm`: Tags the image with the name `my-jenkins-rpm`.

2.  **Run the Jenkins Container:**
    * Run the Docker container from the newly built image:

        ```bash
        docker run -d --name rpm-jenkins -p 8080:8080 my-jenkins-rpm
        ```

        * `-d`: Runs the container in detached (background) mode.
        * `--name rpm-jenkins`: Assigns the name `rpm-jenkins` to the container.
        * `-p 8080:8080`: Maps port 8080 on your host machine to port 8080 in the container, allowing access to the Jenkins web interface.

3.  **Access Jenkins:**
    * Open your web browser and navigate to `http://localhost:8080`.
    * Log in using the default credentials:
        * **User ID:** `admin`
        * **Password:** `admin@123`

4.  **Build the `collect` Job Pipeline:**
    * In Jenkins, configure and build the "collect" job pipeline. This pipeline will generate the `collect_data-1.0-1.noarch.rpm` package.

## Package Installation and Execution

1.  **Install the RPM Package:**
    * After the Jenkins pipeline successfully builds the RPM package, install it on your target Red Hat-based system using:

        ```bash
        sudo dnf install collect_data-1.0-1.noarch.rpm
        ```

        * `sudo`: Provides administrator privileges.
        * `dnf`: The package manager for RHEL and similar distributions.

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