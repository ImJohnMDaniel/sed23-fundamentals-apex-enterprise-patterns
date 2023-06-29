# Hands On Training -- Fundamentals of Apex Enterprise Patterns

This is the sample repo for the [Fundamentals of Apex Enterprise Patterns](https://southeastdreamin.com/sessions/2023/fundamentals-of-apex-enterprise-patterns/) hands-on training session at [Southeast Dreamin' 2023 Salesforce Community Conference](https://southeastdreamin.com) 
## Prerequisites
- Salesforce CLI installed.  Either version list will work..
    - sfdx-cli version 7.200.0 or higher
    - sf version 2.0.0-beta
- VSCode or Salesforce CLI enabled IDE installed
- GitHub.com access 
- Access to a Salesforce Org
    - Salesforce DX Scratch Org (Ideal)
    - Sandbox Org
    - Developer Edition Org 
## Initial Setup
* If you want to use a Scratch Org, 
    * and you are on Windows OS
        * and you are using Powershell or "command prompt" 
            * then execute the command `bin\resetScratchOrg.cmd {org_alias}`
        * and you are using GitBash
            * then execute the command `bin/resetScratchOrg.sh {org_alias}`
    * and you are on MacOS and using the terminal console
        * then execute the command `bin/resetScratchOrg.sh {org_alias}`
* If you want to use a Sandbox Org or a Developer Edition Org, 
    * and you are on Windows OS
        * and you are using Powershell or "command prompt" 
            * then execute the command `bin\setupSandboxOrg.cmd {org_alias}`
        * and you are using GitBash
            * then execute the command `bin/setupSandboxOrg.sh {org_alias}`
    * and you are on MacOS and using the terminal console
        * then execute the command `bin/setupSandboxOrg.sh {org_alias}`
