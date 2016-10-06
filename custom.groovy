import jenkins.model.*

// create dev job
def jobName = "dev"
def configXml = "/usr/share/jenkins/ref/init.groovy.d/jenkins-dev-config.xml"
def xmlStream = new FileInputStream( configXml )
Jenkins.instance.createProjectFromXML(jobName, xmlStream)

// build dev job
def job = Jenkins.instance.getJob(jobName)
Jenkins.instance.queue.schedule(job, 0) 
