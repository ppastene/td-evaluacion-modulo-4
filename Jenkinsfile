pipeline {
    agent any

    stages {
        stage('Clonar repositorio') {
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
        stage('Ejecutar JUnit') {
            steps {
                dir('td-unit-tests') {
                    sh 'mvn clean test'
                }
            }
        }
        stage('Ejecutar SoapUI') {
            steps {
                script {
                    def soapUICommand = '/opt/soapui/bin/testrunner.sh -r -j -d"/opt/soapui/reports" /shared/soapui-evaluacion-final.xml'
                    sh soapUICommand
                }
            }
        }
        stage('Ejecutar JMeter') {
            steps {
                script {
                    // Ejecutar el script de JMeter ubicado en la carpeta shared
                    sh '/opt/jmeter/bin/jmeter -n -t /shared/clase4_m4.jmx -l /shared/results.jtl'
                }
            }
        }
    }

    post {
        always {
            // Archiva los informes generados por JMeter y SoapUI
            archiveArtifacts artifacts: '**/shared/results.jtl', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/opt/soapui/reports/*.xml', allowEmptyArchive: true
        }
    }
}
