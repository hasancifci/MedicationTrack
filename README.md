
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

<p align="center">
<img src="https://user-images.githubusercontent.com/36739258/123164551-c53b5d00-d47b-11eb-832a-84311e4e79b5.jpg" height="600">
</p>

Uygulama başlatıldığında kullanıcı daha önceden sisteme kayıtlı ise giriş yap butonunu
seçerek aşağıda görülen giriş ekranına yönlendirilir. Sisteme kaydı bulunmayan kullanıcı kayıt bölümünden kaydını oluşturup kayıt ol butonuna bastığında kaydı gerçekleşirilir ve giriş ekranına yönlendirilir. Ekranların görünümü aşagıdaki gibidir

<p align="center">
<img src="https://user-images.githubusercontent.com/36739258/123166451-18aeaa80-d47e-11eb-869a-3d4e6540a743.jpg" height="600">
</p>

Uygulamanın ana sayfasının sol alt kısmında bulunan Hatırlatma Ekle butonuna tıklandığında aşağıda görülen ilaç ekleme ekranına geçilir. Burada ilacın adı, ölçeği, günde 
kaç adet alınacağı, hangi saatte alınacağı ve kutudaki ilaç sayısı gibi değerler doldurularak ilaç ekleme işlemi gerçekleştirilir. Saat seçimi için güncel saatin üstüne tıklandığında aşagıdaki şekilde görülen zaman seçim aracı kullanılır.

<p align="center">
<img src="https://user-images.githubusercontent.com/36739258/123166891-92469880-d47e-11eb-80a9-2418b39a3537.jpg" height="600">
</p>

Kullanıcıların eklediği ilaçların adı ve zaman bilgisi uygulamanın ana ekranında aşağıda görüldügü gibi listelenmektedir. Burada bilgilerinde güncelleme yapılmak istenen ilacın üstüne tıklandığında aşağıda görülen güncelleme ekranına yönlendirilir ve burada seçilen ilacın bilgileri gerekli alanlara otomatik olarak doldurulur. Güncellenmek istenen
alanlar degiştirildikten sonra Güncelle butonuna tıklanarak anlık olarak firebase de değişiklikler yapılır ve kullanıcı ana ekrana yönlendirilir.

<p align="center">
<img src="https://user-images.githubusercontent.com/36739258/123167312-0c771d00-d47f-11eb-92ce-af82a3d2e78e.jpg" height="600">
</p>
