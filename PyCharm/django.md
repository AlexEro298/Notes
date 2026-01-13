```html
> pip list
Package  Version
-------- -------
asgiref  3.11.0
Django   6.0.1
pip      25.1.1
sqlparse 0.5.5
tzdata   2025.3
```
```html
> dir feast_inc


    Каталог: C:\Users\alexero\PycharmProjects\feast-inc\feast_inc


Mode                 LastWriteTime         Length Name                                                                                                                                                                             
----                 -------------         ------ ----                                                                                                                                                                             
-a----        12.01.2026     14:09            411 asgi.py                                                                                                                                                                          
-a----        12.01.2026     14:09           3158 settings.py                                                                                                                                                                      
-a----        12.01.2026     14:09            787 urls.py                                                                                                                                                                          
-a----        12.01.2026     14:09            411 wsgi.py                                                                                                                                                                          
-a----        12.01.2026     14:09              0 __init__.py
```
```html
> python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying sessions.0001_initial... OK
```
```html
> python manage.py runserver
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).
January 12, 2026 - 14:12:52
Django version 6.0.1, using settings 'feast_inc.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.

WARNING: This is a development server. Do not use it in a production setting. Use a production WSGI or ASGI server instead.
For more information on production servers see: https://docs.djangoproject.com/en/6.0/howto/deployment/
```
```html
> python manage.py startapp time_display
```
```html
> dir time_display


    Каталог: C:\Users\alexero\PycharmProjects\feast-inc\time_display


Mode                 LastWriteTime         Length Name                                                                                                                                                                             
----                 -------------         ------ ----                                                                                                                                                                             
d-----        12.01.2026     14:15                migrations                                                                                                                                                                       
-a----        12.01.2026     14:15             66 admin.py                                                                                                                                                                         
-a----        12.01.2026     14:15            103 apps.py                                                                                                                                                                          
-a----        12.01.2026     14:15             60 models.py                                                                                                                                                                        
-a----        12.01.2026     14:15             63 tests.py                                                                                                                                                                         
-a----        12.01.2026     14:15             66 views.py                                                                                                                                                                         
-a----        12.01.2026     14:15              0 __init__.py
```
```html
В feast_inc/settings.py добавьте приложение:

# Найдите INSTALLED_APPS и добавьте:
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'time_display',  # ДОБАВЬТЕ ЭТУ СТРОКУ
]

# Убедитесь, что есть:
ALLOWED_HOSTS = ['localhost', '127.0.0.1', 'feast-inc.ru']
```
```html
В time_display/views.py ЗАМЕНИТЕ всё содержимое на:


from django.http import HttpResponse
import datetime
import pytz

def current_time(request):
    # Устанавливаем часовой пояс (можно изменить)
    timezone = pytz.timezone('UTC')
    now = datetime.datetime.now(timezone)
    
    # HTML с красивым дизайном
    html = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Current Time - feast-inc.com</title>
        <meta http-equiv="refresh" content="1"> <!-- Автообновление каждую секунду -->
        <style>
            * {{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }}
            
            body {{
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
                background: linear-gradient(135deg, #1a2980, #26d0ce);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                padding: 20px;
            }}
            
            .container {{
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(20px);
                border-radius: 30px;
                padding: 60px 50px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.2);
                text-align: center;
                max-width: 1000px;
                width: 100%;
            }}
            
            .domain {{
                font-size: 36px;
                font-weight: 300;
                color: #ffffff;
                margin-bottom: 15px;
                letter-spacing: 2px;
            }}
            
            .subtitle {{
                font-size: 20px;
                color: rgba(255, 255, 255, 0.8);
                margin-bottom: 50px;
                font-weight: 300;
            }}
            
            .time {{
                font-size: 120px;
                font-weight: 300;
                font-family: 'Courier New', monospace;
                margin: 40px 0;
                color: #ffffff;
                text-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }}
            
            .date {{
                font-size: 32px;
                color: rgba(255, 255, 255, 0.9);
                margin-bottom: 40px;
            }}
            
            .info {{
                background: rgba(255, 255, 255, 0.1);
                border-radius: 15px;
                padding: 20px;
                margin-top: 40px;
                font-size: 16px;
                color: rgba(255, 255, 255, 0.7);
            }}
            
            .tech {{
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-top: 30px;
                flex-wrap: wrap;
            }}
            
            .tech-badge {{
                background: rgba(255, 255, 255, 0.15);
                padding: 10px 20px;
                border-radius: 50px;
                font-size: 14px;
            }}
            
            @media (max-width: 768px) {{
                .time {{ font-size: 70px; }}
                .date {{ font-size: 24px; }}
                .container {{ padding: 40px 30px; }}
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="domain">feast-inc.com</div>
            <div class="subtitle">Current Server Time</div>
            
            <div class="time" id="liveTime">{now.strftime('%H:%M:%S')}</div>
            <div class="date">{now.strftime('%A, %d %B %Y')}</div>
            
            <div class="info">
                Timezone: {timezone} | Page auto-refreshes every second
            </div>
            
            <div class="tech">
                <div class="tech-badge">Django 6.0.1</div>
                <div class="tech-badge">Python 3.13</div>
                <div class="tech-badge">Development Server</div>
            </div>
        </div>
        
        <script>
            // JavaScript для плавного обновления времени
            function updateLiveTime() {{
                const now = new Date();
                const time = now.toLocaleTimeString('en-US', {{
                    hour12: false,
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                }});
                document.getElementById('liveTime').textContent = time;
            }}
            
            // Обновляем время каждую секунду
            setInterval(updateLiveTime, 1000);
        </script>
    </body>
    </html>
    """
    return HttpResponse(html)
```
```html
В feast_inc/urls.py ЗАМЕНИТЕ всё содержимое на:


from django.contrib import admin
from django.urls import path
from time_display.views import current_time

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', current_time, name='home'),  # Главная страница
]
```
```html
> pip install pytz
Collecting pytz
  Downloading pytz-2025.2-py2.py3-none-any.whl.metadata (22 kB)
Downloading pytz-2025.2-py2.py3-none-any.whl (509 kB)
Installing collected packages: pytz
Successfully installed pytz-2025.2

[notice] A new release of pip is available: 25.1.1 -> 25.3
[notice] To update, run: python.exe -m pip install --upgrade pip
```
```html
> pip freeze > requirements.txt
```
```html
NEW views.py


from django.http import HttpResponse
from datetime import datetime
import pytz

def current_time(request):
    # Выберите нужный часовой пояс:
    # 'UTC' - всемирное время
    # 'Europe/Moscow' - московское время
    # 'America/New_York' - время Нью-Йорка
    # 'Asia/Tokyo' - токийское время
    timezone_str = 'UTC'  # Измените на нужный вам часовой пояс
    
    try:
        tz = pytz.timezone(timezone_str)
        now = datetime.now(tz)
        timezone_name = timezone_str
    except:
        # Если часовой пояс не найден, используем локальное время
        now = datetime.now()
        timezone_name = 'Local Server Time'
    
    # Определяем приветствие по времени суток
    hour = now.hour
    if 5 <= hour < 12:
        greeting = "Good Morning"
    elif 12 <= hour < 18:
        greeting = "Good Afternoon"
    elif 18 <= hour < 22:
        greeting = "Good Evening"
    else:
        greeting = "Good Night"
    
    html = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Current Time - feast-inc.com</title>
        <meta http-equiv="refresh" content="1">
        <style>
            * {{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }}
            
            body {{
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
                background: linear-gradient(135deg, #1a2a6c, #2a5298, #1c92d2);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                padding: 20px;
                animation: gradientShift 15s ease infinite;
                background-size: 200% 200%;
            }}
            
            @keyframes gradientShift {{
                0% {{ background-position: 0% 50%; }}
                50% {{ background-position: 100% 50%; }}
                100% {{ background-position: 0% 50%; }}
            }}
            
            .container {{
                background: rgba(255, 255, 255, 0.12);
                backdrop-filter: blur(25px);
                border-radius: 30px;
                padding: 60px 50px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4),
                            inset 0 1px 0 rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.15);
                text-align: center;
                max-width: 1000px;
                width: 100%;
                animation: fadeIn 0.8s ease-out;
            }}
            
            @keyframes fadeIn {{
                from {{ opacity: 0; transform: translateY(20px); }}
                to {{ opacity: 1; transform: translateY(0); }}
            }}
            
            .greeting {{
                font-size: 24px;
                font-weight: 300;
                color: rgba(255, 255, 255, 0.9);
                margin-bottom: 10px;
                letter-spacing: 1px;
            }}
            
            .domain {{
                font-size: 42px;
                font-weight: 400;
                color: #ffffff;
                margin-bottom: 5px;
                letter-spacing: 2px;
                text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            }}
            
            .subtitle {{
                font-size: 18px;
                color: rgba(255, 255, 255, 0.7);
                margin-bottom: 50px;
                font-weight: 300;
            }}
            
            .time {{
                font-size: 110px;
                font-weight: 300;
                font-family: 'JetBrains Mono', 'Courier New', monospace;
                margin: 30px 0;
                color: #ffffff;
                text-shadow: 0 5px 20px rgba(0, 0, 0, 0.4);
                letter-spacing: 2px;
            }}
            
            .date {{
                font-size: 32px;
                color: rgba(255, 255, 255, 0.9);
                margin-bottom: 15px;
                font-weight: 300;
            }}
            
            .timezone {{
                font-size: 18px;
                color: #4fc3f7;
                margin-bottom: 40px;
                padding: 10px 20px;
                background: rgba(79, 195, 247, 0.1);
                border-radius: 50px;
                display: inline-block;
            }}
            
            .info-panel {{
                background: rgba(255, 255, 255, 0.08);
                border-radius: 15px;
                padding: 25px;
                margin-top: 40px;
                font-size: 15px;
                color: rgba(255, 255, 255, 0.7);
                border: 1px solid rgba(255, 255, 255, 0.05);
            }}
            
            .tech-grid {{
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
                margin-top: 30px;
                text-align: center;
            }}
            
            .tech-card {{
                background: rgba(255, 255, 255, 0.1);
                padding: 15px;
                border-radius: 12px;
                transition: transform 0.3s ease, background 0.3s ease;
            }}
            
            .tech-card:hover {{
                transform: translateY(-5px);
                background: rgba(255, 255, 255, 0.15);
            }}
            
            .tech-title {{
                font-size: 12px;
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 5px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }}
            
            .tech-value {{
                font-size: 16px;
                font-weight: 500;
                color: white;
            }}
            
            .clock-icon {{
                font-size: 80px;
                margin-bottom: 30px;
                opacity: 0.8;
            }}
            
            @media (max-width: 768px) {{
                .time {{ font-size: 65px; }}
                .date {{ font-size: 22px; }}
                .domain {{ font-size: 32px; }}
                .container {{ padding: 40px 25px; }}
                .tech-grid {{ grid-template-columns: 1fr; }}
            }}
            
            @media (max-width: 480px) {{
                .time {{ font-size: 50px; }}
                .date {{ font-size: 18px; }}
                .container {{ padding: 30px 20px; }}
            }}
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <div class="greeting">{greeting}!</div>
            <div class="domain">feast-inc.com</div>
            <div class="subtitle">Live Server Time Display</div>
            
            <div class="clock-icon">
                <i class="fas fa-clock"></i>
            </div>
            
            <div class="time" id="liveTime">{now.strftime('%H:%M:%S')}</div>
            <div class="date">{now.strftime('%A, %d %B %Y')}</div>
            <div class="timezone">
                <i class="fas fa-globe"></i> {timezone_name}
            </div>
            
            <div class="info-panel">
                <div style="margin-bottom: 15px;">
                    <i class="fas fa-sync-alt"></i> Page auto-refreshes every second
                </div>
                <div style="font-size: 13px; color: rgba(255, 255, 255, 0.5);">
                    Server timestamp: {now.strftime('%Y-%m-%d %H:%M:%S %Z')}
                </div>
            </div>
            
            <div class="tech-grid">
                <div class="tech-card">
                    <div class="tech-title">Backend</div>
                    <div class="tech-value">Django 6.0.1</div>
                </div>
                <div class="tech-card">
                    <div class="tech-title">Python</div>
                    <div class="tech-value">Version 3.13</div>
                </div>
                <div class="tech-card">
                    <div class="tech-title">Timezone</div>
                    <div class="tech-value">{timezone_name}</div>
                </div>
                <div class="tech-card">
                    <div class="tech-title">Status</div>
                    <div class="tech-value" style="color: #4CAF50;">
                        <i class="fas fa-circle"></i> Online
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            // Плавное обновление времени с анимацией
            function updateLiveTime() {{
                const now = new Date();
                const timeElement = document.getElementById('liveTime');
                
                if (timeElement) {{
                    // Анимация исчезновения
                    timeElement.style.opacity = '0.5';
                    timeElement.style.transform = 'scale(0.95)';
                    
                    // Обновление времени
                    const time = now.toLocaleTimeString('en-US', {{
                        hour12: false,
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit'
                    }});
                    
                    setTimeout(() => {{
                        timeElement.textContent = time;
                        // Анимация появления
                        timeElement.style.opacity = '1';
                        timeElement.style.transform = 'scale(1)';
                    }}, 150);
                }}
                
                // Обновление приветствия по времени суток
                const hour = now.getHours();
                let greeting = "Welcome";
                if (hour >= 5 && hour < 12) greeting = "Good Morning";
                else if (hour >= 12 && hour < 18) greeting = "Good Afternoon";
                else if (hour >= 18 && hour < 22) greeting = "Good Evening";
                else greeting = "Good Night";
                
                const greetingElement = document.querySelector('.greeting');
                if (greetingElement) {{
                    greetingElement.textContent = greeting + '!';
                }}
            }}
            
            // Обновляем время каждую секунду
            setInterval(updateLiveTime, 1000);
            
            // Инициализация
            updateLiveTime();
            
            // Добавляем эффект при наведении на карточки
            document.addEventListener('DOMContentLoaded', function() {{
                const cards = document.querySelectorAll('.tech-card');
                cards.forEach(card => {{
                    card.addEventListener('mouseenter', function() {{
                        this.style.transform = 'translateY(-5px)';
                    }});
                    card.addEventListener('mouseleave', function() {{
                        this.style.transform = 'translateY(0)';
                    }});
                }});
            }});
        </script>
    </body>
    </html>
    """
    return HttpResponse(html)


# Дополнительная функция для разных часовых поясов (опционально)
def time_in_timezone(request, timezone='UTC'):
    """Страница с выбором часового пояса через URL"""
    try:
        tz = pytz.timezone(timezone)
        now = datetime.now(tz)
    except:
        tz = pytz.UTC
        now = datetime.now(tz)
    
    return HttpResponse(f"""
    <html>
    <body style="font-family: Arial; padding: 20px;">
        <h1>Time in {timezone}</h1>
        <h2>{now.strftime('%H:%M:%S')}</h2>
        <p>{now.strftime('%A, %d %B %Y')}</p>
        <a href="/">Back to main page</a>
    </body>
    </html>
    """)
```