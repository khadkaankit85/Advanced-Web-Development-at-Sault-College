import React from "react";
import "bootstrap/dist/css/bootstrap.min.css";

function App() {
  return (
    <>
      {/* Navbar */}
      <nav className="navbar navbar-expand-lg navbar-light bg-light mb-3">
        <div className="container-fluid">
          <a className="navbar-brand" href="#">
            Your Name
          </a>
          <button
            className="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNav"
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarNav">
            <ul className="navbar-nav ms-auto">
              <li className="nav-item">
                <a className="nav-link" href="#hero-section">
                  Hero Section
                </a>
              </li>
              <li className="nav-item">
                <a className="nav-link" href="#three-column-section">
                  Three Column Section
                </a>
              </li>
              <li className="nav-item">
                <button
                  className="btn btn-primary ms-2"
                  data-bs-toggle="modal"
                  data-bs-target="#copyrightModal"
                >
                  Copyright
                </button>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      {/* Copyright Modal */}
      <div
        className="modal fade"
        id="copyrightModal"
        tabIndex="-1"
        aria-labelledby="copyrightModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title" id="copyrightModalLabel">
                Copyright Information
              </h5>
              <button
                type="button"
                className="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div className="modal-body">© 2025 Your Name. All rights reserved.</div>
            <div className="modal-footer">
              <button
                type="button"
                className="btn btn-secondary"
                data-bs-dismiss="modal"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Hero Section */}
      <section
        id="hero-section"
        className="d-flex align-items-center justify-content-center vh-100 text-white text-center"
        style={{
          backgroundImage: "url('https://via.placeholder.com/1920x1080')",
          backgroundSize: "cover",
          backgroundPosition: "center",
        }}
      >
        <div>
          <h1>Welcome to My Portfolio</h1>
          <p>This is a beautiful hero section with a background image.</p>
        </div>
      </section>

      {/* Three-Column Section */}
      <section id="three-column-section" className="py-5">
        <div className="container">
          <div className="row g-4">
            <div className="col-12 col-md-4">
              <div className="card h-100">
                <img
                  src="https://via.placeholder.com/150"
                  className="card-img-top"
                  alt="Card 1"
                />
                <div className="card-body text-center">
                  <h5 className="card-title">Title 1</h5>
                  <p className="card-text">
                    This is the description for the first card.
                  </p>
                </div>
              </div>
            </div>
            <div className="col-12 col-md-4">
              <div className="card h-100">
                <img
                  src="https://via.placeholder.com/150"
                  className="card-img-top"
                  alt="Card 2"
                />
                <div className="card-body text-center">
                  <h5 className="card-title">Title 2</h5>
                  <p className="card-text">
                    This is the description for the second card.
                  </p>
                </div>
              </div>
            </div>
            <div className="col-12 col-md-4">
              <div className="card h-100">
                <img
                  src="https://via.placeholder.com/150"
                  className="card-img-top"
                  alt="Card 3"
                />
                <div className="card-body text-center">
                  <h5 className="card-title">Title 3</h5>
                  <p className="card-text">
                    This is the description for the third card.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-light text-center py-3">
        © 2025 Your Name. All rights reserved.
      </footer>
    </>
  );
}

export default App;

