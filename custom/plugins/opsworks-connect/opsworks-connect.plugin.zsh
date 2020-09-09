# shellcheck shell=bash

fail() {
  echo "$@"
  usage
  return 1
}

usage() {
  cat <<USAGE
Usage: $0 [-i PRIVATE_KEY] [-u USERNAME] stack_name edit3
USAGE
}

print_verbose() {
  if [[ $verbose ]]; then
    echo "$@"
  fi
}

function connect() {
  private_key=
  username=
  verbose=

  while getopts ":hvi:u:" opt; do
    case ${opt} in
    i) private_key=${OPTARG} ;;
    u) username=${OPTARG} ;;
    h) usage; return 0 ;;
    v) verbose=true ;;
    :) fail "Error: -${OPTARG} requires an argument." ;;
    ?) fail 'Invalid option' ;;
    esac
  done

  shift $((OPTIND-1))

  stack_name="$@"
  print_verbose "Stack name: ${stack_name}"

  if [[ -z "${stack_name}" ]]; then
    fail "Error: stack name is required"
  fi

  print_verbose 'Getting stack ID...'

  stack_id=$(
    aws opsworks describe-stacks \
    | jq -r --arg stack_name "$stack_name" \
      '.Stacks[] | select(.Name == $stack_name) | .StackId'
  )

  print_verbose "Stack ID: ${stack_id}"

  if [[ -z "${stack_id}" ]]; then
    echo "Error fetching stack ID"
    return 1
  fi

  print_verbose 'Getting instance IP...'

  # stack_id=$(jq ".Stacks[] | select(.Name == \"${stack_name}\") | .StackId")
  instance_ip=$(
    aws opsworks describe-instances --stack-id "${stack_id}" \
    | jq -r '[.Instances[].PrivateIp | values] | first' )

  print_verbose "Instance IP: ${instance_ip}"

  if [[ -z "${instance_ip}" ]]; then
    echo "Error fetching stack ID"
    return 1
  fi

  echo "Connecting to instance ${instance_ip}"
  ssh -i "${private_key:-"${HOME}/.ssh/id_rsa"}" ${username:-`whoami`}@${instance_ip}
}
