FROM mambaorg/micromamba:1.5.10

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba create -y -n bilby -f /tmp/environment.yml \
 && micromamba clean --all --yes

ENV PATH=/opt/conda/envs/bilby/bin:$PATH

COPY --chown=$MAMBA_USER:$MAMBA_USER bilby/ /opt/bilby/
RUN pip install --no-deps /opt/bilby

RUN python -c "import bilby, sys; v = bilby.__version__; print('bilby', v, bilby.__file__); \
    sys.exit(0 if v == '0.1.0.dev5476+g9656d84e7' else 1)"

WORKDIR /work
ENTRYPOINT ["python"]
