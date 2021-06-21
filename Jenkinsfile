pipeline {
	agent {
		node { label 'docker' }
	}
	options {
		gitLabConnection 'https://gitlab.corp.gandi.net'
	}
	stages {
		stage('Build docker image') {
			steps{
				sh "docker build --no-cache --force-rm -t hosting-zfs-exporter ."
			}
		}
		stage('Publish') {
			steps{
				sh "docker tag hosting-zfs-exporter registry-docker.sd4.0x35.net:5000/hosting-zfs-exporter"
				sh "docker push registry-docker.sd4.0x35.net:5000/hosting-zfs-exporter"
			}
		}
	}
	post {
		always {
			sh "docker rmi -f `docker images -q -f reference=hosting-zfs-exporter` || :"
			sh "docker rmi -f `docker images -q -f dangling=true` || :"
			sh "docker images"
		}
	}
}

