

String alertUrl(String page) => "https://www.ok.org/wp-json/wp/v2/cpt_kosher_alert?per_page=20&alertcategory=44&page=$page";
String detailsUrl(String name) => "https://www.ok.org/wp-json/fws/v1/krg/?json=1&paging=0&version=$name";
  // String detailsUrl(String name) => "https://www.okkosher.org/consumers/ok-certified-restaurants/?json=1&paging=0&version=$name";
  // String foodUrl(String itemsName) => "https://www.okkosher.org/consumers/kosher-food-guide/?S=&st=$itemsName&V=&C=&json=1&paging=1&perpage=250&version=0.8";
String pagesUrl(String id) => "https://www.ok.org/wp-json/fws/v1/blurb/?id=$id";
String searchUrl(String term, String type, String brand, String category, String pg) => "https://www.ok.org/wp-json/fws/v1/kfg/?S=$term&st=$type&V=$brand&C=$category&json=1&paging=1&pg=$pg&perpage=150&version=0.8";
String searchUrl2(String term, String type, String brand, String category, String pg) => "https://www.okkosher.org/consumers/kosher-food-guide/?S=$term&st=$type&V=$brand&C=$category&json=1&paging=1&pg=$pg&perpage=150&version=0.8";
// &json=1&paging=1&pg=$pg&perpage=150&version=0.8";

// https://www.ok.org/wp-json/fws/v1/kfg/?S=orange+juice&st=&C=&V=Alta+Dena+Dairy+-+North




//// OLD URLS...


  // String alertUrl(String page) => "https://www.okkosher.org/wp-json/wp/v2/alerts?per_page=20&alertcategory=44&page=$page";
  // String detailsUrl(String name) => "https://www.okkosher.org/consumers/ok-certified-restaurants/?json=1&paging=0&version=$name";
  // String foodUrl(String itemsName) => "https://www.okkosher.org/consumers/kosher-food-guide/?S=&st=$itemsName&V=&C=&json=1&paging=1&perpage=250&version=0.8";
  // String pagesUrl(String id) => "https://www.okkosher.org/wp-json/wp/v2/pages/$id";
  // String searchUrl(String term, String type, String brand, String category, String pg) => "https://www.okkosher.org/consumers/kosher-food-guide/?S=$term&st=${type}&V=$brand&C=$category&json=1&paging=1&pg=$pg&perpage=150&version=0.8";

