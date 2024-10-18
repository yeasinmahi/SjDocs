import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

import docker


def is_container_running(container_name):
    client = docker.from_env()
    try:
        container = client.containers.get(container_name)
        return container.status == "running"
    except docker.errors.NotFound:
        return False


def send_email(sender_email, sender_password, receiver_email, subject, body):
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()
    server.login(sender_email, sender_password)
    text = message.as_string()
    server.sendmail(sender_email, receiver_email, text)
    server.quit()


container_names = ["cardaccess", "smarttoilet", "test"]
sender_email = "yeasinmahi70@gmail.com"
sender_password = "kstpkytafsihjtdn"
receiver_email = "arafat.yeasin@surbanajurong.com"
email_subject = "Container Alert"
email_body = f"The following containers are not running:\n"

not_running_containers = []
for container_name in container_names:
    if not is_container_running(container_name):
        not_running_containers.append(container_name)

if not_running_containers:
    print("Some containers are not running. Sending email notification...")
    email_body += "\n".join(not_running_containers)
    send_email(sender_email, sender_password, receiver_email, email_subject, email_body)
else:
    print("All containers are running.")