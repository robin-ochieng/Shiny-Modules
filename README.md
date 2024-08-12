# Shiny-Modules

# Shiny Modules with Namespaces

Welcome to the Shiny Modules repository! This repository showcases the effective use of namespaces in Shiny modules to ensure ID uniqueness across multiple instances within a single application.

## Overview

Shiny modules facilitate the reusability of both server and UI code in R Shiny applications. However, ensuring the uniqueness of element IDs across different module instances can be challenging. This repository provides practical examples and guidelines for implementing namespaces to manage these IDs effectively.

## Name spacing 

- All Ids in a shiny app need to be unique
- Use namespaces to make Id names unique for every module instance
- ns <- NS(id) generates a function that assigns a namespace for every module instance based on its id.i.e
    ns = NS("my_id")
- In the ui part all inputIds/outputIds need to be wrapped with ns i.e
    module_UI <- function(id) {
        ns <- NS(id)
        taglist(
            actionbutton(
                inputId = ns("start_calculation"),
                label = "calculate"
            )
        ) 
    }
- There is no extra work in the server.
- Always input unevaluated reative values into modules.


SUMMARY
- Dont forget ns in the UI
- Always input/output unevaluated reactives(if something should react)
- To dynamically add modules: insertUI/removeUI


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have the following installed:
- R (Download from [CRAN](https://cran.r-project.org/))
- Shiny package in R (`install.packages("shiny")`)

### Installation

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/robin-ochieng/Shiny-Modules.git

### Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. **Fork the Project**
2. **Create your Feature Branch**  
   ```bash
- git checkout -b feature/AmazingFeature

3. **Commit your Changes**
- git commit -m 'Add some AmazingFeature'

4. **Push to the Branch**
- git push origin feature/AmazingFeature

# Contact
- Robin Ochieng - robinochieng73@gmail.com
- Project Link: https://github.com/robin-ochieng/Shiny-Modules
