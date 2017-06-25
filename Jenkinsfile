#!groovy

pipeline {
    agent any

    environment {
        NPM_REPO_URL = credentials('npm-repo-url')
        NPM_REPO = credentials('npm-repo')
    }

    stages {
        stage('Prepare') {
            steps {
                sh 'node --version'
                sh 'npm --version'
            }
        }
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
        stage('Version') {
            steps {
                echo 'Versioning...'
                sh 'printenv'
                sh 'BRANCH_NAME=`git branch | grep "*" | awk \'{print $2}\'`'
                sh 'echo Branch name: ${BRANCH_NAME}'
                sh 'npm version patch -m "[ci-skip] Release %s."'
                sh 'git push origin ${BRANCH_NAME}'
            }
        }
        stage('Archive') {
            steps {
                echo 'Archiving...'
                withNPM(npmrcConfig: 'npmrc-nexus') {
                    sh 'npm publish'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh './deploy.sh'
            }
        }
    }
}
