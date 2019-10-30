
kdb5_util create -r SPYDER.COM -s<<EOF
$MASTER_PASSWORD
$MASTER_PASSWORD
EOF

echo "Adding admin principal"
kadmin.local -q "delete_principal -force admin/admin@SPYDER.COM"
echo ""
kadmin.local -q "addprinc -pw password admin/admin@SPYDER.COM"
echo ""

echo "Adding Alice principal"
kadmin.local -q "delete_principal -force alice@SPYDER.COM"
echo ""
kadmin.local -q "addprinc -pw password alice@SPYDER.COM"
echo ""

echo "Adding Bob principal"
kadmin.local -q "delete_principal -force bob@SPYDER.COM"
echo ""
kadmin.local -q "addprinc -pw password bobn@SPYDER.COM"
echo ""

echo "Adding Eve principal"
kadmin.local -q "delete_principal -force eve@SPYDER.COM"
echo ""
kadmin.local -q "addprinc -pw password eve@SPYDER.COM"
echo ""

krb5kdc
kadmind -nofork
