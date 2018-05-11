FROM python:3

# pip install package
RUN pip install flask
RUN pip install requests

# chaneg the exit port
EXPOSE 5001

# copy the file to image
COPY todolist.db .
COPY todolist_api.py .
COPY todolist.py .
COPY templates/index.html templates/

CMD python todolist_api.py & python todolist.py