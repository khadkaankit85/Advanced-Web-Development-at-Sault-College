
function AfterHero() {
    const columns = [
        {
            image: "https://via.placeholder.com/150",
            title: "Title 1",
            description: "This is the first column description.",
        },
        {
            image: "https://via.placeholder.com/150",
            title: "Title 2",
            description: "This is the second column description.",
        },
        {
            image: "https://via.placeholder.com/150",
            title: "Title 3",
            description: "This is the third column description.",
        },
    ];

    return (
        <section id="three-column-section" className="py-5">
            <div className="container">
                <div className="row g-4">
                    {columns.map((col, index) => (
                        <div className="col-12 col-md-4" key={index}>
                            <div className="card h-100">
                                <img src={col.image} className="card-img-top" alt={col.title} />
                                <div className="card-body text-center">
                                    <h5 className="card-title">{col.title}</h5>
                                    <p className="card-text">{col.description}</p>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}

export default AfterHero;
