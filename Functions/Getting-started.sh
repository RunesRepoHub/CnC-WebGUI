PS3="Select the what you want to install on this server: "

select opt in Agent Server quit; do

  case $opt in
    Agent)
      bash ~/CnC-WebGUI/CnC-Agent/Install-Agent.sh
      ;;
    Server)
      bash ~/CnC-WebGUI/Functions/CnC-Image-Builder.sh
      ;;
    quit)
      break
      ;;
    *) 
      echo "Invalid option $REPLY"
      ;;
  esac
done