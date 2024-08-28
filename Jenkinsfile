pipeline {
    agent any

    stages {
        stage('Clonar ppastene/td-selenium-test') {
            steps {
                script {
                    try {
                        sh 'git clone https://github.com/ppastene/td-selenium-test.git'
                    } catch (Exception e) {
                        echo "El repositorio ya existe, omitiendo la clonación."
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
                    try {
                        sh 'git clone https://github.com/ppastene/td-unit-tests.git'
                    } catch (Exception e) {
                        echo "El repositorio ya existe, omitiendo la clonación."
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
                    sh '/opt/jmeter/bin/jmeter -n -t /shared/clase4_m4.jmx -l /shared/results.jtl'
                }
            }
        }
        stage('Ejecutar SOAPUI') {
            steps {
                script {
                    def soapUICommand = '/opt/soapui/bin/testrunner.sh -r -j -d"/opt/soapui/reports" /shared/soapui-evaluacion-final.xml'
                    sh soapUICommand
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/shared/results.jtl', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/opt/soapui/reports/*.xml', allowEmptyArchive: true
        }
    }
}
