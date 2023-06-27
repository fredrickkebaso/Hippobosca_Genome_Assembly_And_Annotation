


IRs=("FBpp0111921" "GBRI004368-PA" "GMOY004222-PA" "GFUI18_012955.P21290")
ORs=("FBpp0079371" "GBRI036342-PA" "GMOY004392-PA" "GFUI18_011542.P18799")
OBPs=("FBpp0071782" "GMOY006081-PA" "GMOY005400-PA" "GFUI18_008313.P12793")
GRs=("FBpp0077386" "GBRI039848-PA" "GMOY011615-PA" "GFUI18_005954.P8780")
CSPs=("FBpp0079291" "GBRI029095-PA" "GMOY005284-PA")
SNMPs=("GFUI18_006381.P9508" "GBRI029848-PA" "GMOY013276-PA" "FBpp0306711")

control_list=()

# Concatenate all the arrays into the control_list
control_list+=("${IRs[@]}")
control_list+=("${ORs[@]}")
control_list+=("${OBPs[@]}")
control_list+=("${GRs[@]}")
control_list+=("${CSPs[@]}")
control_list+=("${SNMPs[@]}")

# Print the combined list
echo "${control_list[@]}"

