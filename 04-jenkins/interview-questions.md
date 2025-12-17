# Jenkins Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Jenkins?
Jenkins is an open-source automation server that enables continuous integration and continuous delivery (CI/CD). It automates building, testing, and deploying software.

### 2. What is Continuous Integration (CI)?
CI is a development practice where developers frequently integrate code into a shared repository. Each integration is automatically built and tested.

### 3. What is Continuous Delivery (CD)?
CD extends CI by automatically deploying code to staging/production environments after successful builds and tests.

### 4. What is Continuous Deployment?
Continuous Deployment automatically deploys every change that passes tests to production without manual intervention.

### 5. How do you install Jenkins?
- Download and run Jenkins WAR file
- Install via package manager (apt, yum)
- Run in Docker container
- Use Jenkins Helm chart for Kubernetes

### 6. What is the default Jenkins port?
8080

### 7. How do you access Jenkins?
Open a web browser and navigate to `http://localhost:8080` (or your server's IP:8080).

### 8. What is a Jenkins job?
A Jenkins job is a project or task that Jenkins can build, test, or deploy.

### 9. What are the types of Jenkins jobs?
- **Freestyle Project**: Simple, GUI-based job configuration
- **Pipeline**: Code-based CI/CD pipeline (Jenkinsfile)
- **Multi-configuration Project**: Matrix builds
- **Multibranch Pipeline**: Automatically creates jobs for branches

### 10. What is a Jenkinsfile?
A Jenkinsfile is a text file that defines a Jenkins Pipeline. It can be written in Declarative or Scripted syntax and is version-controlled.

### 11. What is the difference between Declarative and Scripted Pipeline?
- **Declarative**: Simpler, structured syntax, easier to read
- **Scripted**: More flexible, uses Groovy scripting, more powerful

### 12. How do you create a Pipeline job?
1. Click "New Item"
2. Enter name and select "Pipeline"
3. Configure pipeline (SCM or Pipeline script)
4. Save

### 13. What is a Jenkins agent?
A Jenkins agent (formerly slave) is a machine that executes build jobs. Agents can be on different operating systems and connect to the master.

### 14. What is the difference between Jenkins master and agent?
- **Master**: Orchestrates builds, manages configuration, schedules jobs
- **Agent**: Executes build jobs, can be on different machines/OS

### 15. What is a Jenkins executor?
An executor is a slot on a Jenkins agent that can run a single build at a time. An agent can have multiple executors.

### 16. How do you trigger a Jenkins build?
- Manual trigger
- SCM polling (checking for changes)
- Webhook (GitHub, GitLab, etc.)
- Scheduled (cron)
- Upstream/downstream projects
- Remote API

### 17. What is build polling?
Build polling checks the SCM repository at specified intervals for changes and triggers a build if changes are detected.

### 18. What is a webhook?
A webhook is an HTTP callback that triggers a Jenkins build when events occur in the SCM (e.g., push to repository).

### 19. How do you view build logs?
Click on a build number, then click "Console Output".

### 20. How do you view build history?
Build history is displayed on the job's main page, showing all past builds.

### 21. What is a build artifact?
A build artifact is a file or collection of files produced during a build (e.g., JAR files, test reports).

### 22. How do you archive artifacts?
In job configuration, use "Archive the artifacts" post-build action, or in Pipeline use `archiveArtifacts`.

### 23. What are Jenkins plugins?
Plugins extend Jenkins functionality. Examples:
- Git plugin
- Docker plugin
- Kubernetes plugin
- SonarQube plugin
- Email extension plugin

### 24. How do you install plugins?
- Via Jenkins UI: Manage Jenkins → Manage Plugins
- Via CLI
- Manually (upload .hpi file)

### 25. What is Blue Ocean?
Blue Ocean is a modern UI for Jenkins that provides a better visual experience for creating and managing pipelines.

### 26. How do you configure Git in Jenkins?
1. Install Git plugin
2. Configure Git in "Global Tool Configuration"
3. Add Git repository URL in job configuration

### 27. What is Jenkins workspace?
A workspace is a directory on the agent where Jenkins checks out source code and runs builds.

### 28. How do you clean workspace?
Use "Clean before checkout" option or `cleanWs()` in Pipeline.

### 29. What is a build parameter?
A build parameter allows you to pass values to a build at runtime.

### 30. How do you add parameters?
In job configuration, select "This project is parameterized" and add parameters (string, choice, boolean, etc.).

### 31. What is a build trigger?
A build trigger defines when a build should be executed automatically.

### 32. What is upstream/downstream project?
- **Upstream**: Project that triggers another project
- **Downstream**: Project triggered by another project

### 33. How do you send email notifications?
Use Email Extension Plugin and configure in post-build actions or Pipeline post section.

### 34. What is Jenkins CLI?
Jenkins CLI is a command-line interface for interacting with Jenkins remotely.

### 35. How do you restart Jenkins?
- Via UI: Manage Jenkins → Prepare for Shutdown
- Via CLI: `java -jar jenkins-cli.jar restart`
- Via system service: `systemctl restart jenkins`

## Medium Level (Questions 36-70)

### 36. Explain Jenkins architecture.
- **Master**: Central Jenkins server that manages builds, schedules jobs, and distributes work
- **Agent/Node**: Machines that execute build jobs
- **Executor**: Slot on agent that runs a single build at a time

### 37. What is a Jenkins node?
A Jenkins node is a machine that can execute Jenkins jobs. Can be a master or agent.

### 38. How do you add a Jenkins agent?
- Via SSH
- Via JNLP (Java Web Start)
- Via cloud providers (AWS, Azure, etc.)
- Static agent configuration

### 39. What is JNLP?
JNLP (Java Network Launch Protocol) is used to launch Jenkins agents.

### 40. How do you configure SSH agent?
1. Add SSH credentials in Jenkins
2. Configure agent with SSH connection
3. Specify host and credentials

### 41. What are the main components of a Pipeline?
- **Agent**: Where the pipeline runs
- **Stages**: Logical divisions of work
- **Steps**: Individual tasks within stages
- **Post**: Actions to run after stages complete

### 42. Explain Jenkins Pipeline stages.
Stages are logical divisions of work in a pipeline. Common stages:
- Checkout
- Build
- Test
- Deploy

### 43. What is the difference between `when` and `if` in pipelines?
- `when`: Used in Declarative pipelines for conditional stage execution
- `if`: Used in Scripted pipelines for conditional logic

### 44. How do you use parallel stages?
```groovy
stage('Test') {
    parallel {
        stage('Unit Tests') {
            steps { sh 'npm test' }
        }
        stage('Integration Tests') {
            steps { sh 'npm run test:integration' }
        }
    }
}
```

### 45. How do you handle build failures?
- Email notifications
- Slack/Teams notifications
- Retry failed stages
- Rollback deployments
- Post-build actions

### 46. What is a shared library in Jenkins?
A shared library is a collection of reusable pipeline code stored in a repository. Allows code reuse across multiple pipelines.

### 47. How do you use a shared library?
Configure in "Manage Jenkins → Configure System → Global Pipeline Libraries" and reference in Jenkinsfile with `@Library('library-name')`.

### 48. Explain Jenkins multibranch pipeline.
A multibranch pipeline automatically creates jobs for each branch in the repository and manages them based on branch lifecycle.

### 49. What is Jenkinsfile from SCM?
Jenkinsfile from SCM allows loading the pipeline definition directly from the source code repository.

### 50. How do you manage credentials in Jenkins?
Jenkins Credentials Plugin allows storing:
- Usernames/passwords
- SSH keys
- Secret files
- Secret text
- Certificates

### 51. How do you use credentials in Pipeline?
```groovy
withCredentials([usernamePassword(credentialsId: 'mycreds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
    sh 'echo $USER:$PASS'
}
```

### 52. What is Jenkins security?
Jenkins security includes:
- Authentication (who can access)
- Authorization (what they can do)
- Credential management
- CSRF protection

### 53. Explain Jenkins user roles.
- **Admin**: Full access
- **Developer**: Can trigger builds, view results
- **Viewer**: Read-only access

### 54. How do you configure matrix builds?
Use "Multi-configuration Project" to run builds across multiple configurations (e.g., different OS, browsers).

### 55. What is build discarder?
Build discarder automatically deletes old builds to save disk space.

### 56. How do you configure build discarder?
In job configuration, use "Discard old builds" or in Pipeline use `options { buildDiscarder(...) }`.

### 57. What is workspace cleanup?
Workspace cleanup removes files from the workspace before/after builds to prevent conflicts and save disk space.

### 58. How do you integrate test results?
- JUnit plugin for test results
- Publish test results in post section
- Archive test reports

### 59. How do you publish test results?
```groovy
post {
    always {
        junit 'test-results/**/*.xml'
    }
}
```

### 60. What is SonarQube integration?
SonarQube integration allows running code quality analysis in Jenkins pipelines.

### 61. How do you integrate SonarQube?
Install SonarQube plugin and use `withSonarQubeEnv` in Pipeline.

### 62. What is Docker integration in Jenkins?
Docker integration allows building Docker images and running containers in Jenkins pipelines.

### 63. How do you use Docker in Pipeline?
```groovy
stage('Build') {
    steps {
        script {
            def image = docker.build("myapp:${env.BUILD_NUMBER}")
            image.push()
        }
    }
}
```

### 64. What is Kubernetes integration in Jenkins?
Kubernetes integration allows running Jenkins agents as Kubernetes pods.

### 65. How do you configure Kubernetes plugin?
Configure Kubernetes cloud in "Manage Jenkins → Configure System → Cloud" with Kubernetes cluster details.

### 66. What is pipeline as code?
Pipeline as code means defining pipelines in code (Jenkinsfile) rather than through UI, enabling version control and code review.

### 67. How do you handle secrets in Jenkins?
- Credentials Plugin
- HashiCorp Vault integration
- Environment variables (less secure)
- Secret files

### 68. What is Jenkins X?
Jenkins X is a cloud-native CI/CD solution built on top of Jenkins, designed for Kubernetes environments.

### 69. What is the difference between `sh` and `bat` in pipelines?
- `sh`: For Unix/Linux commands
- `bat`: For Windows batch commands

### 70. How do you set environment variables in Pipeline?
```groovy
environment {
    NODE_ENV = 'production'
    VERSION = "${env.BUILD_NUMBER}"
}
```

## High/Advanced Level (Questions 71-100)

### 71. What are Jenkins best practices?
- Use Pipelines (Jenkinsfile)
- Version control Jenkinsfiles
- Use agents for builds
- Implement proper security
- Use credentials plugin
- Clean workspace after builds
- Use parallel stages when possible
- Implement proper notifications

### 72. How do you optimize Jenkins performance?
- Use agents for builds
- Clean workspace regularly
- Archive old builds
- Use build discarder
- Optimize plugin usage
- Use parallel stages
- Cache dependencies

### 73. How do you backup Jenkins?
- Backup JENKINS_HOME directory
- Use ThinBackup plugin
- Export configuration as XML
- Backup plugins

### 74. How do you restore Jenkins from backup?
Restore JENKINS_HOME directory or use ThinBackup plugin restore functionality.

### 75. What is JENKINS_HOME?
JENKINS_HOME is the directory where Jenkins stores all its configuration, jobs, and build history.

### 76. How do you migrate Jenkins?
- Copy JENKINS_HOME to new server
- Export/import jobs
- Use Jenkins CLI
- Use configuration as code

### 77. What is Configuration as Code (JCasC)?
JCasC allows managing Jenkins configuration through YAML files, enabling infrastructure as code.

### 78. How do you use JCasC?
Install Configuration as Code plugin and provide YAML configuration file.

### 79. What is Jenkins pipeline library?
A pipeline library is a shared library containing reusable pipeline code, steps, and utilities.

### 80. How do you create a pipeline library?
Create a Git repository with `vars/` directory for global variables and `src/` for classes.

### 81. What is pipeline step?
A pipeline step is a single operation in a pipeline (e.g., `sh`, `echo`, `git`).

### 82. How do you create custom pipeline steps?
Create Groovy scripts in shared library `vars/` directory.

### 83. What is pipeline DSL?
Pipeline DSL (Domain-Specific Language) is the syntax used to define Jenkins pipelines.

### 84. How do you debug Jenkins pipelines?
- Use `echo` statements
- Check console output
- Use Pipeline Syntax generator
- Enable debug mode
- Check agent connectivity
- Review logs

### 85. What is pipeline replay?
Pipeline replay allows re-running a pipeline with modified script without committing changes.

### 86. How do you handle pipeline failures?
Use `post` section with `failure`, `success`, `always` blocks to handle different outcomes.

### 87. What is pipeline timeout?
Pipeline timeout allows setting maximum execution time for a pipeline or stage.

### 88. How do you set pipeline timeout?
```groovy
options {
    timeout(time: 1, unit: 'HOURS')
}
```

### 89. What is pipeline retry?
Pipeline retry allows automatically retrying failed stages.

### 90. How do you retry a stage?
```groovy
retry(3) {
    sh 'unstable-command'
}
```

### 91. What is pipeline input?
Pipeline input allows pausing pipeline execution for user input.

### 92. How do you use pipeline input?
```groovy
input message: 'Deploy to production?', ok: 'Deploy'
```

### 93. What is pipeline lock?
Pipeline lock allows locking resources to prevent concurrent access.

### 94. How do you use pipeline lock?
```groovy
lock('my-resource') {
    // Critical section
}
```

### 95. What is pipeline stash/unstash?
Stash/unstash allows saving and restoring files across stages and nodes.

### 96. How do you use stash?
```groovy
stash includes: 'target/**', name: 'artifacts'
unstash 'artifacts'
```

### 97. What is pipeline script approval?
Script approval is a security feature that requires admin approval for certain scripts.

### 98. How do you approve scripts?
Go to "Manage Jenkins → In-process Script Approval" and approve pending scripts.

### 99. What is Jenkins distributed builds?
Distributed builds allow running builds on multiple agents, improving performance and scalability.

### 100. How do you troubleshoot failed builds?
- Check console output
- Review build logs
- Check agent connectivity
- Verify dependencies
- Check disk space
- Review permissions
- Check plugin compatibility
- Review system logs
