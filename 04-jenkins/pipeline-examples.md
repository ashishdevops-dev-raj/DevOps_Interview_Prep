# Jenkins Pipeline Examples

## Basic Declarative Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'npm install'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'npm test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
```

## Pipeline with Environment Variables

```groovy
pipeline {
    agent any
    
    environment {
        NODE_VERSION = '18'
        APP_NAME = 'myapp'
    }
    
    stages {
        stage('Build') {
            steps {
                sh "node --version"
                echo "Building ${APP_NAME}"
            }
        }
    }
}
```

## Pipeline with Parameters

```groovy
pipeline {
    agent any
    
    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Version to deploy')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Environment')
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip tests')
    }
    
    stages {
        stage('Deploy') {
            steps {
                echo "Deploying version ${params.VERSION} to ${params.ENVIRONMENT}"
                if (!params.SKIP_TESTS) {
                    sh 'npm test'
                }
            }
        }
    }
}
```

## Pipeline with Parallel Stages

```groovy
pipeline {
    agent any
    
    stages {
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'npm run test:unit'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'npm run test:integration'
                    }
                }
                stage('E2E Tests') {
                    steps {
                        sh 'npm run test:e2e'
                    }
                }
            }
        }
    }
}
```

## Pipeline with Docker

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def image = docker.build("myapp:${env.BUILD_NUMBER}")
                    image.push()
                }
            }
        }
        
        stage('Run Container') {
            steps {
                sh 'docker run -d -p 8080:80 myapp:${env.BUILD_NUMBER}'
            }
        }
    }
    
    post {
        always {
            sh 'docker stop $(docker ps -q --filter ancestor=myapp:${env.BUILD_NUMBER})'
        }
    }
}
```

## Pipeline with Kubernetes Deployment

```groovy
pipeline {
    agent any
    
    environment {
        KUBECONFIG = credentials('kubeconfig')
    }
    
    stages {
        stage('Deploy to K8s') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl rollout status deployment/myapp
                '''
            }
        }
    }
}
```

## Pipeline with Conditional Stages

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Test') {
            when {
                not { branch 'main' }
            }
            steps {
                sh 'npm test'
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                sh 'kubectl apply -f k8s/staging/'
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                sh 'kubectl apply -f k8s/production/'
            }
        }
    }
}
```

## Pipeline with Notifications

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed'
        }
        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build successful!",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build failed. Check console output.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
```

## Pipeline with Artifacts

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'dist/**/*', fingerprint: true
            }
        }
    }
}
```

## Pipeline with SonarQube Integration

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
```

## Multi-branch Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo "Building branch: ${env.BRANCH_NAME}"
                sh 'npm install'
            }
        }
        
        stage('Test') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                sh 'npm test'
            }
        }
    }
}
```

## Pipeline with Credentials

```groovy
pipeline {
    agent any
    
    stages {
        stage('Deploy') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY',
                        passwordVariable: 'AWS_SECRET_KEY'
                    )
                ]) {
                    sh '''
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY}
                        aws s3 sync . s3://my-bucket/
                    '''
                }
            }
        }
    }
}
```

## Pipeline with Retry and Timeout

```groovy
pipeline {
    agent any
    
    stages {
        stage('Deploy') {
            steps {
                retry(3) {
                    timeout(time: 5, unit: 'MINUTES') {
                        sh 'kubectl apply -f k8s/'
                    }
                }
            }
        }
    }
}
```

## Pipeline with Workspace Cleanup

```groovy
pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        cleanWs()
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
```

