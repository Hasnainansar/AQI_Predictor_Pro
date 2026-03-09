#!/bin/bash

# Air Quality Prediction System - Run Script
# This script helps run different components of the system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check Python installation
check_python() {
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed"
        exit 1
    fi
    print_success "Python 3 found: $(python3 --version)"
}

# Create virtual environment
setup_venv() {
    print_header "Setting up Virtual Environment"
    
    if [ ! -d "venv" ]; then
        print_info "Creating virtual environment..."
        python3 -m venv venv
        print_success "Virtual environment created"
    else
        print_info "Virtual environment already exists"
    fi
    
    # Activate virtual environment
    source venv/bin/activate
    print_success "Virtual environment activated"
}

# Install dependencies
install_deps() {
    print_header "Installing Dependencies"
    
    if [ -f "requirements_streamlit.txt" ]; then
        print_info "Installing from requirements_streamlit.txt..."
        pip install -q -r requirements_streamlit.txt
        print_success "Dependencies installed"
    else
        print_error "requirements_streamlit.txt not found"
        exit 1
    fi
}

# Run training pipeline
run_training() {
    print_header "Running Training Pipeline"
    
    if [ -f "train_pipeline.py" ]; then
        print_info "Starting model training..."
        python3 train_pipeline.py
        print_success "Training completed"
    else
        print_error "train_pipeline.py not found"
        exit 1
    fi
}

# Run predictions
run_predictions() {
    print_header "Running Predictions"
    
    if [ -f "predict.py" ]; then
        print_info "Starting predictions..."
        python3 predict.py
        print_success "Predictions completed"
    else
        print_error "predict.py not found"
        exit 1
    fi
}

# Run Streamlit app
run_streamlit() {
    print_header "Running Streamlit Application"
    
    if [ -f "app.py" ]; then
        print_info "Starting Streamlit app..."
        print_info "Open browser at: http://localhost:8501"
        streamlit run app.py
    else
        print_error "app.py not found"
        exit 1
    fi
}

# Run dashboard
run_dashboard() {
    print_header "Running Dashboard"
    
    if [ -f "dashboard.py" ]; then
        print_info "Starting dashboard..."
        print_info "Open browser at: http://localhost:8501"
        streamlit run dashboard.py
    else
        print_error "dashboard.py not found"
        exit 1
    fi
}

# Show menu
show_menu() {
    echo ""
    print_header "Air Quality Prediction System"
    echo ""
    echo "Select an option:"
    echo "  1) Setup environment (install dependencies)"
    echo "  2) Run training pipeline"
    echo "  3) Run predictions"
    echo "  4) Run Streamlit app"
    echo "  5) Run dashboard"
    echo "  6) Full setup and run app"
    echo "  7) Exit"
    echo ""
}

# Main script
main() {
    check_python
    
    # If no argument provided, show menu
    if [ $# -eq 0 ]; then
        while true; do
            show_menu
            read -p "Enter your choice [1-7]: " choice
            
            case $choice in
                1)
                    setup_venv
                    install_deps
                    ;;
                2)
                    if [ ! -d "venv" ]; then
                        setup_venv
                        install_deps
                    fi
                    source venv/bin/activate
                    run_training
                    ;;
                3)
                    if [ ! -d "venv" ]; then
                        setup_venv
                        install_deps
                    fi
                    source venv/bin/activate
                    run_predictions
                    ;;
                4)
                    if [ ! -d "venv" ]; then
                        setup_venv
                        install_deps
                    fi
                    source venv/bin/activate
                    run_streamlit
                    ;;
                5)
                    if [ ! -d "venv" ]; then
                        setup_venv
                        install_deps
                    fi
                    source venv/bin/activate
                    run_dashboard
                    ;;
                6)
                    setup_venv
                    install_deps
                    source venv/bin/activate
                    run_streamlit
                    ;;
                7)
                    print_info "Exiting..."
                    exit 0
                    ;;
                *)
                    print_error "Invalid option. Please try again."
                    ;;
            esac
        done
    else
        # Handle command line arguments
        case $1 in
            setup)
                setup_venv
                install_deps
                ;;
            train)
                if [ ! -d "venv" ]; then
                    setup_venv
                    install_deps
                fi
                source venv/bin/activate
                run_training
                ;;
            predict)
                if [ ! -d "venv" ]; then
                    setup_venv
                    install_deps
                fi
                source venv/bin/activate
                run_predictions
                ;;
            app)
                if [ ! -d "venv" ]; then
                    setup_venv
                    install_deps
                fi
                source venv/bin/activate
                run_streamlit
                ;;
            dashboard)
                if [ ! -d "venv" ]; then
                    setup_venv
                    install_deps
                fi
                source venv/bin/activate
                run_dashboard
                ;;
            *)
                print_error "Unknown command: $1"
                echo "Usage: $0 {setup|train|predict|app|dashboard}"
                exit 1
                ;;
        esac
    fi
}

# Run main function
main "$@"
