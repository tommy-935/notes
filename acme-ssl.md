# free ssl install step

1. curl  https://get.acme.sh | sh
2. alias acme.sh=~/.acme.sh/acme.sh  # .bashrc or .zshrc or .config/fish/fish.
3. aliyun platform get ali_key ali_secret
4. export Ali_Key="sdfsdfsdfljlbjkljlkjsdfoiwje"
5. export Ali_Secret="jlsdflanljkljlfdsaklkjflsa"
acme.sh --register-account -m lai@1918726170003456.onaliyun.com
6. acme.sh --issue --dns dns_ali -d example.com -d *.example.com 
7. nginx conf fill the fullchain.cer and example.com.key
8. reload nginx
9. acme.sh --upgrade --auto-upgrade (auto update acme.sh)
10. acme.sh --renew -d example.com --force (update cert by yourself)
11. "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" (crontab task auto update cert)
12. done