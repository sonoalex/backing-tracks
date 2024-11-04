# Use an official Python runtime as a parent image
FROM python:3.12-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install any needed packages specified in requirements.txt
# install python dependencies
RUN pip install --upgrade pip \
        && pip install --no-cache-dir -r app/requirements.txt

# Expose the port that Gunicorn will run on
EXPOSE 8000

# Run gunicorn with 3 workers and bind to the container's port 8000
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "main:app"]
