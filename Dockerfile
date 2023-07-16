# BUILDER STAGE
# Docker should use the official python 3 images usng dockerhub as a base image
FROM python:3.11.3-alpine AS builder

# Create virtual environment
RUN python -m venv /opt/votingenv

# Activate the virtual environment
ENV PATH="/opt/votingenv/bin:$PATH"

# install psycog2 dependencies
RUN apk update && \
    apk add postgresql dev gcc python3-dev musl-dev libpq-dev

# install dependencies from requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt


# OPERATIONAL STAGE
FROM python:3.11.3-alpine

# Get venv from builder stage
COPY --from=builder /opt/votingenv /opt/votingenv

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/votingenv/bin:$PATH"

#  Set the container's working directory to /app
WORKDIR /app

# copy project
COPY . /app/
