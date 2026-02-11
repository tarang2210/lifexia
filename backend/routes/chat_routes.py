from flask import Blueprint, request, jsonify
import uuid

chat_bp = Blueprint('chat', __name__, url_prefix='/api/chat')

@chat_bp.route('/init', methods=['POST'])
def init_chat():
    data = request.get_json()
    session_id = f"session_{uuid.uuid4().hex}"
    return jsonify({
        'session_id': session_id,
        'welcome_message': "Welcome to LifeXia! I'm your intelligent pharmacy assistant. How can I help you today?"
    }), 200

@chat_bp.route('/message', methods=['POST'])
def handle_message():
    data = request.get_json()
    message = data.get('message')
    # Mock response for now
    return jsonify({
        'message': f"I received your message: '{message}'. Currently, my knowledge base is being initialized. Please ask me again shortly!"
    }), 200
