pipeline {
    agent any

    stages {
        stage('Clonar ppastene/td-selenium-test') {
            steps {
                script {
                    def repoDir = 'td-selenium-test'
                    if (fileExists(repoDir)) {
                        dir(repoDir) {
                            sh 'git pull'
                        }
                    } else {
                        sh 'git clone https://github.com/ppastene/td-selenium-test.git'
                    }
                }
            }
        }
        stage('Ejecutar Selenium Tests') {
            steps {
                dir('td-selenium-test') {
                    sh 'mvn clean test'
                }
            }
        }
        stage('Clonar ppastene/td-unit-tests') {
            steps {
                script {
                    def repoDir = 'td-unit-tests'
                    if (fileExists(repoDir)) {
                        dir(repoDir) {
                            sh 'git pull'
                        }
                    } else {
                        sh 'git clone https://github.com/ppastene/td-unit-tests.git'
                    }
                }
            }
        }
        stage('Ejecutar JUnit') {
            steps {
                dir('td-unit-tests') {
                    sh 'mvn clean test'
                }
            }
        }
        stage('Verificar archivos en shared') {
            steps {
                sh 'ls -la /shared'
            }
        }
        stage('Ejecutar JMeter') {
            steps {
                script {
                    sh '/opt/jmeter/bin/jmeter -n -t /shared/clase4_m4.jmx -l /shared/reports/jmeter-report.jtl'
                }
            }
        }
        stage('Ejecutar SOAPUI') {
            steps {
                script {
                    sh  '/opt/soapui/bin/testrunner.sh -r -j -f "soapui-report.xml" -d "/shared/reports" /shared/soapui-evaluacion-final.xml'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/shared/reports/*.xml', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/shared/reports/*.jtl', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/shared/reports/*.xml', allowEmptyArchive: true
        }
    }
}
