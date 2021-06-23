
# İlaç Takip Otomasyonu

Bu proje Android işletim sistemine sahip kullanıcılara yönelik olup, kullandıkları ilaçları
takip ederek zamanında kullanım yapmaları ve kalan ilaç adetlerini takip edebilmeleri
amacıyla geliştirildi.

Proje kapsamında verilerin güvenli olarak tutulması için Google tarafından desteklenen
Firebase veri tabanı kullanıldı. Bu verilerin işlenmesi ve arayüzde gösterilmesi için yine
Google tarafından açık kaynak kod şeklinde sunulan Flutter kütüphanelerinden yararlanıldı.

Bu proje ile kullanıcılar internete bağlı oldukları her yerden ilaçlarının saatinden tam vaktinde 
haberdar olacak ve kullandıgı ilaçların kalan kullanımlarını görebilecek. Bu proje
sayesinde kullanıcılar eksik ve zamansız ilaç kullanımının önüne geçmiş ve sağlıklarını
tehlikeye atabilecek durumlardan korunmuş olacaktır.

## Projenin Tasarımı Ve Çalışma Yapısı

Uygulama ilk önce bir giriş/kayıt ekranı ile başlamaktadır. Buradan giriş yapan veya yeni
kayıt yapan kullanıcıyı uygulamanın ana ekranı karşılamaktadır. Ana ekranda kullanıcının daha önceden kayıt ettigi ilaçları rahatlıkla görebilmesi için anlık olarak firebase de 
yapılan degişiklikleri uygulamaya yansıtabilen StreamBuilder widget yapısı kullanıldı.
Bu widgetın kullanılmasında ki amaç hızlı sonuç vermesi, arayüz kısmında kullanışlı bir
görsellige sahip olması ve sade olması önemli rol oynamaktadır. StreamBuilder yapısının 
ve başlangıç ekranının görünümü aşagıda görüldüğü gibidir.


<img src="https://user-images.githubusercontent.com/36739258/123164551-c53b5d00-d47b-11eb-832a-84311e4e79b5.jpg" width="500" height="600">
