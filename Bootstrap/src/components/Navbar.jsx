
function Navbar() {
  return (
    <>
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

      {/* Modal for Copyright */}
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
    </>
  );
}

export default Navbar;

