# Personal Data Analysis Template

This is my personal data analysis project template, designed to facilitate work with both STATA and Python. A prepared LaTeX template for write-ups and documentation is included, along with utility scripts, to streamline the project initialization and data analysis process. If you find this useful or have feedback, let me know.

## Usage and Overview 

- **Initialization Script (`./script/init.sh`):** Run to initialize project repository and install required packages automatically. 
    - Initializes the project repository.
    - Sets up a virtual environment (`venv`).
    - Installs necessary Python packages from `requirements.txt`.
    - Configures `pystata` to align with my local machine settings.
- **STATA Run Script (`stata.sh`):** I add this to my PATH so I can quickly run my STATA do file from the terminal with my preferred preconfigured options. 
    - Add a header to the `.do` file.
    - Append a footer to the `.do` file.
    - Set the working directory in STATA.
    - Execute the `.do` file in silent mode (`-e` by default).
    - Display the log file content.
    - Commit changes to Git if everything runs successfully.
- **LaTeX Template:** I've refined this template over time, tailoring it with several custom commands. It's crafted to streamline the creation of well-formatted homework assignments and data analysis write-ups.
- **CAUTION: .gitignore:** Is set to ignore LaTeX build files, `venv` folder, and contents of the data folder.