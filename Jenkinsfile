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
            when {
                branch 'master'
            }
            steps {
                echo 'Versioning...'
                sh 'npm version patch -m "[ci-skip] Release %s."'
                sshagent (credentials: ['jenkins-ssh']) {
                    sh 'git push origin `git branch | grep "*" | awk \'{print $2}\'`'
                }
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
