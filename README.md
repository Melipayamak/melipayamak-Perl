# melipayamak Perl

<div dir='rtl'>

### معرفی وب سرویس ملی پیامک
ملی پیامک یک وب سرویس کامل برای ارسال و دریافت پیامک و پیامک صوتی و مدیریت کامل خدمات دیگر است که براحتی میتوانید از آن استفاده کنید.

<hr>

### نصب

<p>قبل از نصب نیاز به ثبت نام در سایت ملی پیامک دارید.</p>

[**ثبت نام به همراه دریافت 200 پیامک هدیه جهت تست وبسرویس**](http://www.melipayamak.com/)

</div>

<div dir='rtl'>
  
#### نحوه استفاده

نمونه کد برای ارسال پیامک

</div>


```perl
my $username = "username";
my $password = "password";
my $from = "5000...";
my $to = "09123456789";
my $text = "تست وب سرویس ملی پیامک";
my $isFlash = false;
my $soapClient = new SoapClient($username, $password);
$soapClient->SendSimpleSMS2($to, $from, $text, $isFlash);
//یا برای ارسال به مجموعه ای از مخاطبین
$soapClient->SendSimpleSMS(@to, $from, $text, $isFlash);
```

<div dir='rtl'>

از آنجا که وب سرویس ملی پیامک تنها محدود به ارسال پیامک نیست شما از طریق زیر میتوانید به وب سرویس ها دسترسی کامل داشته باشید:
</div>

```perl
// وب سرویس پیامک
my $restClient = new RestClient($username, $password);
my $soapClient = new SoapClient($username, $password);
```

<div dir='rtl'>
  
#### تفاوت های وب سرویس پیامک rest و soap

از آنجا که ملی پیامک وب سرویس کاملی رو در اختیار توسعه دهندگان میگزارد برای راحتی کار با وب سرویس پیامک علاوه بر وب سرویس اصلی soap وب سرویس rest رو هم در اختیار توسعه دهندگان گزاشته شده تا راحتتر بتوانند با وب سرویس کار کنند. تفاوت اصلی این دو در تعداد متد هاییست که میتوانید با آن کار کنید. برای کار های پایه میتوان از وب سرویس rest استفاده کرد برای دسترسی بیشتر و استفاده پیشرفته تر نیز باید از وب سرویس باید از وب سرویس soap استفاده کرد. جهت مطالعه بیشتر وب سرویس ها به قسمت وب سرویس پنل خود مراجعه کنید.

<hr/>


###  اطلاعات بیشتر

برای مطالعه بیشتر و دریافت راهنمای وب سرویس ها و آشنایی با پارامتر های ورودی و خروجی وب سرویس به صفحه معرفی
[وب سرویس ملی پیامک](https://github.com/Melipayamak/Webservices)
مراجعه نمایید .


<hr/>

متدهای وب سرویس:

</div>

#### ارسال

```perl
$restClient->Send($to, $from, $text, $isFlash);
$soapClient->SendSimpleSMS(@to , $from, $text, $isFlash);
```
<div dir='rtl'>
  در آرگومان سوم روش soap میتوانید از هر تعداد مخاطب به عنوان آرایه استفاده کنید
</div>

#### دریافت وضعیت ارسال
```perl
$restClient->GetDelivery($recId);
$soapClient->GetDelivery($recId);
$soapClient->GetDeliveries(@recIds);
```

#### لیست پیامک ها

```perl
$restClient->GetMessages($location, $index, $count, $from);
$soapClient->getMessages($location, $from, $index, $count);
// جهت دریافت به صورت رشته ای
$soapClient->GetMessagesByDate($location, $from, $index, $count, $dateFrom, $dateTo);
//جهت دریافت بر اساس تاریخ
$soapClient->GetUsersMessagesByDate($location, $from, $index, $count, $dateFrom, $dateTo);
// جهت دریافت پیام های کاربران بر اساس تاریخ 
```

#### موجودی
```perl
$restClient->GetCredit();
$soapClient->GetCredit();
```

#### تعرفه پایه / دریافت قیمت قبل از ارسال
```perl
$restClient->GetBasePrice();
$soapClient->GetSmsPrice($irancellCount, $mtnCount, $from, $text);
```
#### لیست شماره اختصاصی
```perl
$soapClient->GetUserNumbers();
```

#### بررسی تعداد پیامک های دریافتی
```perl
$soapClient->GetInboxCount($isRead);
//پیش فرض خوانده نشده 
```

#### ارسال پیامک پیشرفته
```perl
$soapClient->SendSms(@to, $from, $text, $isflash, $udh, @recId, @status);
```

#### مشاهده مشخصات پیام
```perl
$soapClient->GetMessagesReceptions($msgId, $fromRows);
```


#### حذف پیام دریافتی
```perl
$soapClient->RemoveMessages2($location, $msgIds);
```


#### ارسال زماندار
```perl
$soapClient->AddSchedule($to, $from, $text, $isflash, $scheduleDateTime, $period);
```

#### ارسال زماندار متناظر
```perl
$soapClient->AddMultipleSchedule(@to, $from, @text, $isflash, @scheduleDateTime, $period);
```


#### ارسال سررسید
```perl
$soapClient->AddNewUsance($to, $from, $text, $isflash, $scheduleStartDateTime, $countRepeat, $scheduleEndDateTime, $periodType);
```

#### مشاهده وضعیت ارسال زماندار
```perl
$soapClient->GetScheduleStatus($schId);
```

#### حذف پیامک زماندار
```perl
$soapClient->RemoveSchedule($schId);
```


####  ارسال پیامک همراه با تماس صوتی
```perl
$soapClient->SendSMSWithSpeechText($smsBody, $speechBody, $from, $to);
```

####  ارسال پیامک همراه با تماس صوتی به صورت زمانبندی
```perl
$soapClient->SendSMSWithSpeechTextBySchduleDate($smsBody, $speechBody, $from, $to, $scheduleDate);
```

####  دریافت وضعیت پیامک همراه با تماس صوتی 
```perl
$soapClient->GetSendSMSWithSpeechTextStatus($recId);
```
<div dir='rtl'>
  
### وب سرویس ارسال انبوه/منطقه ای

</div>

#### دریافت شناسه شاخه های بانک شماره
```perl
$soapClient->GetBranchs($owner);
```


#### اضافه کردن یک بانک شماره جدید
```perl
$soapClient->AddBranch($branchName, $owner);
```

#### اضافه کردن شماره به بانک
```perl
$soapClient->AddNumber($branchId, @mobileNumbers);
```

#### حذف یک بانک
```perl
$soapClient->RemoveBranch($branchId);
```

#### ارسال انبوه از طریق بانک
```perl
$soapClient->AddBulk($from, $branch, $bulkType, $title, $message, $rangeFrom, $rangeTo, $DateToSend, $requestCount, $rowFrom);
```

#### تعداد شماره های موجود
```perl
$soapClient->GetBulkCount($branch, $rangeFrom, $rangeTo);
```

#### گزارش گیری از ارسال انبوه
```perl
$soapClient->GetBulkReceptions($bulkId, $fromRows);
```


#### تعیین وضعیت ارسال 
```perl
$soapClient->GetBulkStatus($bulkId, $sent, $failed, $status);
```

#### تعداد ارسال های امروز
```perl
$soapClient->GetTodaySent();
```

#### تعداد ارسال های کل

```perl
$soapClient->GetTotalSent();
```

#### حذف ارسال منطقه ای
```perl
$soapClient->RemoveBulk($bulkId);
```

#### ارسال متناظر
```perl
$soapClient->SendMultipleSMS(@to, $from, @text, $isflash, $udh, @recId, $status);
```

#### نمایش دهنده وضعیت گزارش گیری

```perl
$soapClient->UpdateBulkDelivery($bulkId);
```
<div dir='rtl'>
  
### وب سرویس تیکت

</div>

#### ثبت تیکت جدید
```perl
$soapClient->AddTicket($title, $content, $aletWithSms);
```

#### جستجو و دریافت تیکت ها

```perl
$soapClient->GetReceivedTickets($ticketOwner, $ticketType, $keyword);
```

#### دریافت تعداد تیکت های کاربران
```perl
$soapClient->GetReceivedTicketsCount($ticketType);
```

#### دریافت تیکت های ارسال شده
```perl
$soapClient->GetSentTickets($ticketOwner, $ticketType, $keyword);
```

#### دریافت تعداد تیکت های ارسال شده
```perl
$soapClient->GetSentTicketsCount($ticketType);
```


#### پاسخگویی به تیکت
```perl
$soapClient->ResponseTicket($ticketId, $type, $content, $alertWithSms);
```
<div dir='rtl'>
  
### وب سرویس دفترچه تلفن

</div>

#### اضافه کردن گروه جدید
```perl
$soapClient->AddGroup($groupName, $Descriptions, $showToChilds);
```

#### اضافه کردن کاربر جدید
```perl
$soapClient->AddContact(options);
```

#### بررسی موجود بودن شماره در دفترچه تلفن
```perl
$soapClient->CheckMobileExistInContact($mobileNumber);
```

#### دریافت اطلاعات دفترچه تلفن
```perl
$soapClient->GetContacts($groupId, $keyword, $count);
```
#### دریافت گروه ها
```perl
$soapClient->GetGroups();
```
#### ویرایش مخاطب
```perl
$soapClient->ChangeContact(options);
```

#### حذف مخاطب
```perl
$soapClient->RemoveContact($mobilenumber);
```
#### دریافت اطلاعات مناسبت های فرد
```perl
$soapClient->GetContactEvents($contactId);
```

<div dir='rtl'>

### وب سرویس کاربران

</div>

#### ثبت فیش واریزی
```perl
$soapClient->AddPayment(options);
```

#### اضافه کردن کاربر جدید در سامانه
```perl
$soapClient->AddUser(options);
```

#### اضافه کردن کاربر جدید در سامانه(کامل)
```perl
$soapClient->AddUserComplete(options);
```

#### اضافه کردن کاربر جدید در سامانه(WithLocation)
```perl
$soapClient->AddUserWithLocation(options);
```
#### بدست آوردن ID کاربر
```perl
$soapClient->AuthenticateUser();
```
#### تغییر اعتبار
```perl
$soapClient->ChangeUserCredit($amount, $description, $targetUsername, $GetTax);
```

#### فراموشی رمز عبور
```perl
$soapClient->ForgotPassword($mobileNumber, $emailAddress, $targetUsername);
```
#### دریافت تعرفه پایه کاربر
```perl
$soapClient->GetUserBasePrice($targetUsername);
```

#### دریافت اعتبار کاربر
```perl
$soapClient->GetUserCredit($targetUsername);
```

#### دریافت مشخصات کاربر
```perl
$soapClient->GetUserDetails($targetUsername);
```

#### دریافت شماره های کاربر
```perl
$soapClient->GetUserNumbers();
```

#### دریافت تراکنش های کاربر
```perl
$soapClient->GetUserTransactions($targetUsername, $creditType, $dateFrom, $dateTo, $keyword);
```

#### دریافت اطلاعات  کاربران
```perl
$soapClient->GetUsers();
```


#### دریافت اطلاعات  فیلترینگ
```perl
$soapClient->HasFilter($text);
```


####  حذف کاربر
```perl
$soapClient->RemoveUser($targetUsername);
```


#### مشاهده استان ها
```perl
$soapClient->GetProvinces();
```

#### مشاهده کد شهرستان 
```perl
$soapClient->GetCities($provinceId);
```


#### مشاهده تاریخ انقضای کاربر 
```perl
$soapClient->GetExpireDate();
```
