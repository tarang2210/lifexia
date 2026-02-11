from flask import Flask, render_template
from flask_cors import CORS
from backend.config import config
from backend.utils import init_db

def create_app(config_name='default'):
    app = Flask(__name__, 
                template_folder='../frontend/templates',
                static_folder='../frontend/static')
    
    app.config.from_object(config[config_name])
    CORS(app)
    init_db(app)
    
    from backend.routes.auth_routes import auth_bp
    from backend.routes.chat_routes import chat_bp
    from backend.routes.whatsapp_routes import whatsapp_bp
    app.register_blueprint(auth_bp)
    app.register_blueprint(chat_bp)
    app.register_blueprint(whatsapp_bp)
    
    @app.route('/')
    def index():
        return render_template('index.html')
    
    @app.route('/health')
    def health():
        return {'status': 'healthy', 'service': 'LifeXia'}, 200
    
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0', port=5000)
