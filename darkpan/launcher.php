<?php
$command = 'echo "';
if(filter_has_var(INPUT_POST,'checkbox_disk')) {
        $command .= "disk ";
}
if(filter_has_var(INPUT_POST,'checkbox_wifi')) {
        $command .= "wifi ";
}
if(filter_has_var(INPUT_POST,'checkbox_bluetooth')) {
        $command .= "bluetooth ";
}
if(filter_has_var(INPUT_POST,'checkbox_audio')) {
        $command .= "audio ";
}
if(filter_has_var(INPUT_POST,'checkbox_fan')) {
        $command .= "fan ";
}
if(filter_has_var(INPUT_POST,'checkbox_battery')) {
        $command .= 'battery';
}
$command .='"> checkinglist';
echo $command;

$pipe = shell_exec($command);
echo "<pre>$pipe</pre>";
?>
